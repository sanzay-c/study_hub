import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';

part 'notes_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotesModel {
  @JsonKey(name: '_id')
  String id;
  String? groupId;
  String? uploadedBy;
  String? title;
  String? description;
  String? filePath;
  String? fileType;
  int? fileSize;
  DateTime? createdAt;
  String? uploaderUsername;
  dynamic uploaderAvatar;
  String? groupName;

  NotesModel({
    required this.id,
    this.groupId,
    this.uploadedBy,
    this.title,
    this.description,
    this.filePath,
    this.fileType,
    this.fileSize,
    this.createdAt,
    this.uploaderUsername,
    this.uploaderAvatar,
    this.groupName,
  });

  NotesModel copyWith({
    String? id,
    String? groupId,
    String? uploadedBy,
    String? title,
    String? description,
    String? filePath,
    String? fileType,
    int? fileSize,
    DateTime? createdAt,
    String? uploaderUsername,
    dynamic uploaderAvatar,
    String? groupName,
  }) {
    return NotesModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      createdAt: createdAt ?? this.createdAt,
      uploaderUsername: uploaderUsername ?? this.uploaderUsername,
      uploaderAvatar: uploaderAvatar ?? this.uploaderAvatar,
      groupName: groupName ?? this.groupName,
    );
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      groupId: json['group_id']?.toString(),
      uploadedBy: json['uploaded_by']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      filePath: json['file_path']?.toString(),
      fileType: json['file_type']?.toString(),
      fileSize: (json['file_size'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']?.toString() ?? ''),
      uploaderUsername: json['uploader_username']?.toString(),
      uploaderAvatar: json['uploader_avatar'],
      groupName: json['group_name']?.toString(),
    );
  }
  Map<String, dynamic> toJson() => _$NotesModelToJson(this);

  NotesEntity toEntity() {
    return NotesEntity(
      id: id,
      groupId: groupId ?? '',
      uploadedBy: uploadedBy ?? '',
      title: title,
      description: description,
      filePath: filePath ?? '',
      fileType: fileType ?? '',
      fileSize: fileSize ?? 0,
      createdAt: createdAt,
      uploaderUsername: uploaderUsername ?? 'Unknown',
      uploaderAvatar: EnvConfig.resolveImageUrl(uploaderAvatar as String?),
      groupName: groupName ?? 'Unknown',
    );
  }

}