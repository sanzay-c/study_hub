import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';
import 'package:study_hub/features/notes/domain/repo/notes_repo.dart';

@injectable
class GetMyNotesUseCase {
  final NotesRepo repository;

  GetMyNotesUseCase({required this.repository});

  Future<List<NotesEntity>> call({
    required int page,
    required int limit,
  }) {
    return repository.getMyNotes(page: page, limit: limit);
  }
}