import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/data/datasource/notes_remote_datasource.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';
import 'package:study_hub/features/notes/domain/repo/notes_repo.dart';

@LazySingleton(as: NotesRepo)
class NotesRepoImpl implements NotesRepo {
  final NoteRemoteDataSource noteRemoteDataSource;

  NotesRepoImpl({required this.noteRemoteDataSource});

  @override
  Future<List<NotesEntity>> getDiscoverNotes({
    required int page,
    required int limit,
  }) async {
    try {
      final result = await noteRemoteDataSource.getDiscoverNotes(  
        page: page,
        limit: limit,
      );
      return result.map((e) => e.toEntity()).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString()); 
    }
  }

  @override
  Future<List<NotesEntity>> getMyNotes({
    required int page,
    required int limit,
  }) async {
    try {
      final result = await noteRemoteDataSource.getMyNotes(  
        page: page,
        limit: limit,
      );
      return result.map((e) => e.toEntity()).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());  
    }
  }

  @override
  Future<void> downloadNote({
    required String noteId,
    required String fileName,
  }) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final savePath = "${directory!.path}/$fileName";

      await noteRemoteDataSource.downloadNote(
        noteId: noteId,
        savePath: savePath,
      );
    } catch (e) {
      throw Exception("Download failed: ${e.toString()}");
    }
  }
}