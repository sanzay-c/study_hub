// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesModel _$NotesModelFromJson(Map<String, dynamic> json) => NotesModel(
  id: json['_id'] as String,
  groupId: json['group_id'] as String?,
  uploadedBy: json['uploaded_by'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  filePath: json['file_path'] as String?,
  fileType: json['file_type'] as String?,
  fileSize: (json['file_size'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  uploaderUsername: json['uploader_username'] as String?,
  uploaderAvatar: json['uploader_avatar'],
  groupName: json['group_name'] as String?,
);

Map<String, dynamic> _$NotesModelToJson(NotesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'group_id': instance.groupId,
      'uploaded_by': instance.uploadedBy,
      'title': instance.title,
      'description': instance.description,
      'file_path': instance.filePath,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'created_at': instance.createdAt?.toIso8601String(),
      'uploader_username': instance.uploaderUsername,
      'uploader_avatar': instance.uploaderAvatar,
      'group_name': instance.groupName,
    };
