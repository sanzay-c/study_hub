import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';

@lazySingleton
class GetChatHistoryUseCase {
  final ChatRepository repository;
  GetChatHistoryUseCase(this.repository);

  Future<List<ChatMessageEntity>> call({
    required String id, 
    required bool isGroup, 
    required String currentUserId
  }) {
    return isGroup 
        ? repository.getGroupHistory(id, currentUserId) 
        : repository.getDMHistory(id, currentUserId);
  }
}