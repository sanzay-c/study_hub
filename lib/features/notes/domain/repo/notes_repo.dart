import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';

abstract class NotesRepo {
  Future<List<NotesEntity>> getMyNotes({required int page, required int limit, String? search});

  Future<List<NotesEntity>> getDiscoverNotes({
    required int page,
    required int limit,
    String? search,
  });

  Future<void> downloadNote({required String noteId, required String fileName});

  Future<void> uploadNote({required String groupId, required String filePath});
}
