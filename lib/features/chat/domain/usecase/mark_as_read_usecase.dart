import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';

@lazySingleton
class MarkAsReadUseCase {
  final ChatRepository repository;
  MarkAsReadUseCase(this.repository);

  Future<void> call({required String id, required bool isGroup}) async {
    await repository.markAsRead(id, isGroup: isGroup);
  }
}
