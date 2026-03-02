import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotePreviewScreen extends StatefulWidget {
  final NotesEntity note;

  const NotePreviewScreen({super.key, required this.note});

  @override
  State<NotePreviewScreen> createState() => _NotePreviewScreenState();
}

class _NotePreviewScreenState extends State<NotePreviewScreen> {
  String? _localPath;
  String? _token;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initPreview();
  }

  Future<void> _initPreview() async {
    try {
      // 1. Check if file exists in permanent "Download" folder
      final fileName = widget.note.filePath.split('/').last;
      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
        if (!await downloadDir.exists()) {
          downloadDir = await getExternalStorageDirectory();
        }
      } else {
        downloadDir = await getApplicationDocumentsDirectory();
      }

      final permanentPath = "${downloadDir!.path}/$fileName";
      if (await File(permanentPath).exists()) {
        setState(() {
          _localPath = permanentPath;
          _isLoading = false;
        });
        return;
      }

      // 2. Get Auth Token for networking
      final authLocalDataSource = getIt<AuthLocalDataSource>();
      final tokenModel = await authLocalDataSource.getCachedToken();
      _token = tokenModel?.accessToken;

      final isPdf = widget.note.fileType.toLowerCase().contains('pdf');
      
      // 3. For PDFs: Since flutter_pdfview only opens local files, 
      // we download to a temporary cache if not already present.
      if (isPdf) {
        final tempDir = await getTemporaryDirectory();
        final tempFilePath = "${tempDir.path}/temp_$fileName";
        
        if (!await File(tempFilePath).exists()) {
          final dio = getIt<Dio>();
          final baseUrl = dotenv.env['BASE_URL'] ?? '';
          final url = "$baseUrl${ApiEndpoints.downloadNotes(widget.note.id)}";
          
          await dio.download(
            url,
            tempFilePath,
            options: Options(headers: {'Authorization': 'Bearer $_token'}),
          );
        }
        
        setState(() {
          _localPath = tempFilePath;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Error loading preview: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final url = "$baseUrl${ApiEndpoints.downloadNotes(widget.note.id)}";
    final isPdf = widget.note.fileType.toLowerCase().contains('pdf');

    return Scaffold(
      backgroundColor: getColorByTheme(context: context, colorClass: AppColors.backgroundColor),
      appBar: StudyHubAppBar(
        title: widget.note.title ?? "Preview",
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, textAlign: TextAlign.center))
              : _buildPreview(url, isPdf),
    );
  }

  Widget _buildPreview(String url, bool isPdf) {
    if (isPdf) {
      if (_localPath == null) return const Center(child: Text("PDF not found"));
      return PDFView(
        filePath: _localPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          debugPrint("PDFView Error: $error");
        },
        onPageError: (page, error) {
          debugPrint("PDFView Page Error: $page: $error");
        },
      );
    } else {
      // Use local file for images if available (FASTER)
      if (_localPath != null) {
        return Center(child: Image.file(File(_localPath!)));
      }

      // Otherwise stream securely
      return Center(
        child: CachedNetworkImage(
          imageUrl: url,
          httpHeaders: {'Authorization': 'Bearer $_token'},
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              Text("Error loading preview"),
            ],
          ),
        ),
      );
    }
  }
}
