// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostNotesModel _$PostNotesModelFromJson(Map<String, dynamic> json) =>
    PostNotesModel(
      id: json['_id'] as String,
      groupId: json['group_id'] as String,
      uploadedBy: json['uploaded_by'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      filePath: json['file_path'] as String,
      fileType: json['file_type'] as String,
      fileSize: (json['file_size'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      groupName: json['group_name'] as String,
    );

Map<String, dynamic> _$PostNotesModelToJson(PostNotesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'group_id': instance.groupId,
      'uploaded_by': instance.uploadedBy,
      'title': instance.title,
      'description': instance.description,
      'file_path': instance.filePath,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'created_at': instance.createdAt.toIso8601String(),
      'group_name': instance.groupName,
    };
