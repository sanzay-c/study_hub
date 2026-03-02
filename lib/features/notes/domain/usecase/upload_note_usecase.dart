import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/domain/repo/notes_repo.dart';

@injectable
class UploadNoteUseCase {
  final NotesRepo repository;

  UploadNoteUseCase({required this.repository});

  Future<void> call({required String groupId, required String filePath}) async {
    return await repository.uploadNote(
      groupId: groupId,
      filePath: filePath,
    );
  }
}
