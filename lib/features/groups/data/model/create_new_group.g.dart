// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewGroup _$CreateNewGroupFromJson(Map<String, dynamic> json) =>
    CreateNewGroup(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      subject: json['subject'],
      createdBy: json['created_by'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isPublic: json['is_public'] as bool,
      imagePath: json['image_path'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      creatorName: json['creator_name'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$CreateNewGroupToJson(CreateNewGroup instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'subject': instance.subject,
      'created_by': instance.createdBy,
      'members': instance.members,
      'is_public': instance.isPublic,
      'image_path': instance.imagePath,
      'created_at': instance.createdAt.toIso8601String(),
      'creator_name': instance.creatorName,
      'image_url': instance.imageUrl,
    };
