// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: unused_element
GetGroupsModel _$GetGroupsModelFromJson(Map<String, dynamic> json) =>
    GetGroupsModel(
      id: json['_id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      subject: json['subject'] as String?,
      createdBy: json['created_by'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isPublic: json['is_public'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      creatorName: json['creator_name'] as String?,
      imageUrl: json['image_url'] as String?,
      onlineCount: (json['online_count'] as num?)?.toInt(),
      imagePath: json['image_path'] as String?,
      lastMessageTime: json['last_message_time'] == null
          ? null
          : DateTime.parse(json['last_message_time'] as String),
      unreadCount: (json['unread_count'] as num?)?.toInt(),
      lastMessageText: json['last_message_text'] as String?,
    );

Map<String, dynamic> _$GetGroupsModelToJson(GetGroupsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'subject': instance.subject,
      'created_by': instance.createdBy,
      'members': instance.members,
      'is_public': instance.isPublic,
      'created_at': instance.createdAt?.toIso8601String(),
      'creator_name': instance.creatorName,
      'image_url': instance.imageUrl,
      'online_count': instance.onlineCount,
      'image_path': instance.imagePath,
      'last_message_time': instance.lastMessageTime?.toIso8601String(),
      'unread_count': instance.unreadCount,
      'last_message_text': instance.lastMessageText,
    };
