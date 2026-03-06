// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_groups_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupsDetailModel _$GetGroupsDetailModelFromJson(
  Map<String, dynamic> json,
) => GetGroupsDetailModel(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  subject: json['subject'] as String?,
  createdBy: json['created_by'] as String?,
  members: json['members'] as List<dynamic>?,
  isPublic: json['is_public'] as bool?,
  imagePath: json['image_path'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  creatorName: json['creator_name'] as String?,
  imageUrl: json['image_url'],
  memberCount: (json['member_count'] as num?)?.toInt(),
  membersPreview: (json['members_preview'] as List<dynamic>?)
      ?.map((e) => MembersPreview.fromJson(e as Map<String, dynamic>))
      .toList(),
  notesPreview: json['notes_preview'] as List<dynamic>?,
  onlineCount: (json['online_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$GetGroupsDetailModelToJson(
  GetGroupsDetailModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'subject': instance.subject,
  'created_by': instance.createdBy,
  'members': instance.members,
  'is_public': instance.isPublic,
  'image_path': instance.imagePath,
  'created_at': instance.createdAt?.toIso8601String(),
  'creator_name': instance.creatorName,
  'image_url': instance.imageUrl,
  'member_count': instance.memberCount,
  'members_preview': instance.membersPreview,
  'notes_preview': instance.notesPreview,
  'online_count': instance.onlineCount,
};

MembersPreview _$MembersPreviewFromJson(Map<String, dynamic> json) =>
    MembersPreview(
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      fullname: json['fullname'] as String?,
      avatarPath: json['avatar_path'] as String?,
      isOnline: json['is_online'] as bool?,
      isOwner: json['is_owner'] as bool?,
    );

Map<String, dynamic> _$MembersPreviewToJson(MembersPreview instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'fullname': instance.fullname,
      'avatar_path': instance.avatarPath,
      'is_online': instance.isOnline,
      'is_owner': instance.isOwner,
    };
