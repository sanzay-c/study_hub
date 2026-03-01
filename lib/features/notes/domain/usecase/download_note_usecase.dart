
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/domain/repo/notes_repo.dart';

@injectable
class DownloadNoteUseCase {
  final NotesRepo repository;

  DownloadNoteUseCase({required this.repository});

  Future<void> call({
    required String noteId,
    required String fileName,
  }) {
    return repository.downloadNote(noteId: noteId, fileName: fileName);
  }
}
