import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'post_notes_model.g.dart'; 

@JsonSerializable(fieldRename: FieldRename.snake)
class PostNotesModel {
  @JsonKey(name: '_id')
  final String id;
  final String groupId;
  final String uploadedBy;
  final String title;
  final String description;
  final String filePath;
  final String fileType;
  final int fileSize;
  final DateTime createdAt;
  final String groupName;

  PostNotesModel({
    required this.id,
    required this.groupId,
    required this.uploadedBy,
    required this.title,
    required this.description,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
    required this.groupName,
  });

  PostNotesModel copyWith({
    String? id,
    String? groupId,
    String? uploadedBy,
    String? title,
    String? description,
    String? filePath,
    String? fileType,
    int? fileSize,
    DateTime? createdAt,
    String? groupName,
  }) {
    return PostNotesModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      createdAt: createdAt ?? this.createdAt,
      groupName: groupName ?? this.groupName,
    );
  }

  factory PostNotesModel.fromJson(Map<String, dynamic> json) => _$PostNotesModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostNotesModelToJson(this);

  factory PostNotesModel.fromRawJson(String str) => PostNotesModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}