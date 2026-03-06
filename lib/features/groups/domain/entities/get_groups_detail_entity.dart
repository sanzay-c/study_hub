import 'package:equatable/equatable.dart';

class GetGroupsDetailEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String subject;
  final String createdBy;
  final List<String> members;
  final bool isPublic;
  final dynamic imagePath;
  final DateTime createdAt;
  final String creatorName;
  final dynamic imageUrl;
  final int memberCount;
  final List<MembersPreviewEntity> membersPreview;
  final List<dynamic> notesPreview;
  final int onlineCount;

  const GetGroupsDetailEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.createdBy,
    required this.members,
    required this.isPublic,
    required this.imagePath,
    required this.createdAt,
    required this.creatorName,
    required this.imageUrl,
    required this.memberCount,
    required this.membersPreview,
    required this.notesPreview,
    required this.onlineCount,
  });

  @override
  List<Object?> get props => [id, name, members, memberCount];
}

class MembersPreviewEntity extends Equatable {
  final String userId;
  final String username;
  final String fullname;
  final String? avatarPath; // String → String?
  final bool isOnline;
  final bool isOwner;

  const MembersPreviewEntity({
    required this.userId,
    required this.username,
    required this.fullname,
    this.avatarPath, // required हटा
    required this.isOnline,
    required this.isOwner,
  });

  @override
  List<Object?> get props => [userId, username, isOnline];
}