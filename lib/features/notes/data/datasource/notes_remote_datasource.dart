
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/notes/data/model/notes_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NotesModel>> getMyNotes({required int page, required int limit});
  Future<List<NotesModel>> getDiscoverNotes({required int page, required int limit});
  Future<void> downloadNote({required String noteId, required String savePath});
}

@LazySingleton(as: NoteRemoteDataSource)
class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio dio; 

  NoteRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NotesModel>> getMyNotes({required int page, required int limit}) async {
    final response = await dio.get(
      ApiEndpoints.myNotes,
      queryParameters: {'page': page, 'limit': limit},
    );
    return (response.data as List)
        .map((e) => NotesModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> downloadNote({required String noteId, required String savePath}) async {
    await dio.download(
      ApiEndpoints.downloadNotes(noteId),
      savePath,
    );
  }

  @override
  Future<List<NotesModel>> getDiscoverNotes({required int page, required int limit}) async {
    final response = await dio.get(
      ApiEndpoints.discoverNotes,
      queryParameters: {'page': page, 'limit': limit},
    );
    return (response.data as List)
        .map((e) => NotesModel.fromJson(e))
        .toList();
  }
}