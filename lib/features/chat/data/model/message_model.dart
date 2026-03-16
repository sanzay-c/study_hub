import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel {
  final String id;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final DateTime timestamp;
  final String? senderName;
  final String? senderAvatarUrl;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    required this.timestamp,
    this.senderName,
    this.senderAvatarUrl,
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
      senderName: json['sender_username'] ?? 
                  json['sender_name'] ?? 
                  json['username'] ?? 
                  json['name'],
      senderAvatarUrl: EnvConfig.resolveImageUrl(
        json['sender_avatar'] ?? 
        json['sender_avatar_url'] ??
        json['avatar_path']
      ),
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
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
    );
  }
}
