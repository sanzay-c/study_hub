import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';

class RecentDmModel {
  final String userId;
  final String username;
  final String fullname;
  final String? avatarPath;
  final bool isOnline;
  final RecentMessageModel? lastMessage;

  RecentDmModel({
    required this.userId,
    required this.username,
    required this.fullname,
    this.avatarPath,
    required this.isOnline,
    this.lastMessage,
  });

  factory RecentDmModel.fromJson(Map<String, dynamic> json) {
    return RecentDmModel(
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      fullname: json['fullname'] ?? '',
      avatarPath: json['avatar_path'],
      isOnline: json['is_online'] ?? false,
      lastMessage: json['last_message'] != null
          ? RecentMessageModel.fromJson(json['last_message'])
          : null,
    );
  }

  GetGroupsEntity toEntity() {
    return GetGroupsEntity(
      id: userId, // DMs use the target user's ID as the chat ID
      name: username,
      description: fullname, // Showing fullname as description for DMs
      createdBy: userId,
      members: [],
      isPublic: false,
      createdAt: lastMessage?.timestamp ?? DateTime.now(),
      imageUrl: EnvConfig.resolveImageUrl(avatarPath),
      onlineCount: isOnline ? 1 : 0,
      lastMessageTime: lastMessage?.timestamp,
      lastMessageText: lastMessage?.content,
      unreadCount: (lastMessage?.read == false) ? 1 : 0, // Simplified unread logic
      isGroup: false,
      otherUserId: userId,
    );
  }
}

class RecentMessageModel {
  final String id;
  final String roomId;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool read;

  RecentMessageModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.read,
  });

  factory RecentMessageModel.fromJson(Map<String, dynamic> json) {
    return RecentMessageModel(
      id: json['_id'] ?? '',
      roomId: json['room_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      read: json['read'] ?? true,
    );
  }
}
