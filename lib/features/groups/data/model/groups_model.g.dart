// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupsModel _$GroupsModelFromJson(Map<String, dynamic> json) => GroupsModel(
  id: json['_id'] as String,
  name: json['name'] as String?,
  description: json['description'] as String?,
  subject: json['subject'] as String?,
  createdBy: json['created_by'] as String?,
  members: (json['members'] as List<dynamic>).map((e) => e as String?).toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  onlineCount: (json['online_count'] as num).toInt(),
  isPublic: json['is_public'] as bool?,
  imagePath: json['image_path'] as String?,
);

Map<String, dynamic> _$GroupsModelToJson(GroupsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'subject': instance.subject,
      'created_by': instance.createdBy,
      'members': instance.members,
      'created_at': instance.createdAt.toIso8601String(),
      'online_count': instance.onlineCount,
      'is_public': instance.isPublic,
      'image_path': instance.imagePath,
    };
