import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';

part 'groups_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GroupsModel {
  @JsonKey(name: '_id')
  final String id;
  final String? name;
  final String? description;
  final String? subject;
  final String? createdBy;
  final List<String?> members;
  final DateTime createdAt;
  final int onlineCount;
  final bool? isPublic;
  final String? imagePath;

  GroupsModel({
    required this.id,
    this.name,
    this.description,
    this.subject,
    this.createdBy,
    required this.members,
    required this.createdAt,
    required this.onlineCount,
    this.isPublic,
    this.imagePath,
  });

  GroupsModel copyWith({
    String? id,
    String? name,
    String? description,
    String? subject,
    String? createdBy,
    List<String?>? members,
    DateTime? createdAt,
    int? onlineCount,
    bool? isPublic,
    String? imagePath,
  }) {
    return GroupsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      onlineCount: onlineCount ?? this.onlineCount,
      isPublic: isPublic ?? this.isPublic,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  factory GroupsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GroupsModelToJson(this);

  factory GroupsModel.fromRawJson(String str) =>
      GroupsModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  GroupsEntity toEntity() {
    return GroupsEntity(
      id: id,
      name: name ?? 'Untitled Group',
    );
  }
}
