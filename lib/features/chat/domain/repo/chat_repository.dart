import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRepository {
  // Real-time operations
  Stream<dynamic> connectToDM(String userIdA, String userIdB, String token); //
  Stream<dynamic> connectToGroup(String groupId, String token); //
  void sendMessage(Map<String, dynamic> messageData); //
  void closeConnection(); //

  // History operations (HTTP)
  Future<List<ChatMessageEntity>> getDMHistory(String otherUserId, String currentUserId);
  Future<List<ChatMessageEntity>> getGroupHistory(String groupId, String currentUserId);
}