import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel {
  final String id;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'],
      groupId: json['group_id'],
      content: json['content'] ?? json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  ChatMessageEntity toEntity(String currentUserId) {
    return ChatMessageEntity(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      groupId: groupId,
      content: content,
      timestamp: timestamp,
      isMe: senderId == currentUserId,  
    );
  }
}
