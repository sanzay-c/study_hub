import 'dart:developer';

import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';

class RecentDmModel {
  final String userId;
  final String username;
  final String fullname;
  final String? avatarPath;
  final bool isOnline;
  final RecentMessageModel? lastMessage;
  final int unreadCount;

  RecentDmModel({
    required this.userId,
    required this.username,
    required this.fullname,
    this.avatarPath,
    required this.isOnline,
    this.lastMessage,
    required this.unreadCount,
  });

  factory RecentDmModel.fromJson(Map<String, dynamic> json) {
    final count = json['unread_count'] ?? 0;
    log("DEBUG: RecentDmModel for ${json['username']} parsed unread_count: $count");
    return RecentDmModel(
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      fullname: json['fullname'] ?? '',
      avatarPath: json['avatar_path'],
      isOnline: json['is_online'] ?? false,
      unreadCount: count,
      lastMessage: json['last_message'] != null
          ? RecentMessageModel.fromJson(json['last_message'])
          : null,
    );
  }

  GetGroupsEntity toEntity() {
    return GetGroupsEntity(
      id: userId,
      name: username,
      description: fullname,
      createdBy: userId,
      members: [],
      isPublic: false,
      createdAt: lastMessage?.timestamp ?? DateTime.now(),
      imageUrl: EnvConfig.resolveImageUrl(avatarPath),
      onlineCount: isOnline ? 1 : 0,
      lastMessageTime: lastMessage?.timestamp,
      lastMessageText: lastMessage?.content,
      unreadCount: unreadCount,
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
