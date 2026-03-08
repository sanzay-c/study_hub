import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';

@lazySingleton
class SendChatMessageUseCase {
  final ChatRepository repository;
  SendChatMessageUseCase(this.repository);

  void call({
    required String message,
    required String senderId,
    String? receiverId,
    bool isGroup = false,
  }) {
    final Map<String, dynamic> data = {
      "message": message,
      "sender_id": senderId,
    };
    
    if (!isGroup) {
      data["receiver_id"] = receiverId;
    }

    repository.sendMessage(data);
  }
}