import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';

part 'notes_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotesModel {
  @JsonKey(name: '_id')
  String id;
  String groupId;
  String uploadedBy;
  String? title;
  String? description;
  String filePath;
  String fileType;
  int fileSize;
  DateTime? createdAt;
  String uploaderUsername;
  dynamic uploaderAvatar;
  String groupName;

  NotesModel({
    required this.id,
    required this.groupId,
    required this.uploadedBy,
    this.title,
    this.description,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    this.createdAt,
    required this.uploaderUsername,
    this.uploaderAvatar,
    required this.groupName,
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

  factory NotesModel.fromJson(Map<String, dynamic> json) =>
      _$NotesModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotesModelToJson(this);



  NotesEntity toEntity() {
    return NotesEntity(
      id: id,
      groupId: groupId,
      uploadedBy: uploadedBy,
      title: title,
      description: description,
      filePath: filePath,
      fileType: fileType,
      fileSize: fileSize,
      createdAt: createdAt,
      uploaderUsername: uploaderUsername,
      uploaderAvatar: uploaderAvatar,
      groupName: groupName,
    );
  }

}