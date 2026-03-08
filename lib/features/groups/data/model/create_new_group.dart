import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';

part 'create_new_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateNewGroup {
  @JsonKey(
    name: '_id',
  )
  final String id;
  final String name;
  final String description;
  final dynamic subject;
  final String? createdBy;
  final List<String>? members;
  final bool? isPublic;
  final String? imagePath;
  final DateTime? createdAt;
  final String? creatorName;
  final String? imageUrl;

  CreateNewGroup({
    required this.id,
    required this.name,
    required this.description,
    this.subject,
    this.createdBy,
    this.members,
    this.isPublic,
    this.imagePath,
    this.createdAt,
    this.creatorName,
    this.imageUrl,
  });

  CreateNewGroup copyWith({
    String? id,
    String? name,
    String? description,
    dynamic subject,
    String? createdBy,
    List<String>? members,
    bool? isPublic,
    String? imagePath,
    DateTime? createdAt,
    String? creatorName,
    String? imageUrl,
  }) => CreateNewGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    subject: subject ?? this.subject,
    createdBy: createdBy ?? this.createdBy,
    members: members ?? this.members,
    isPublic: isPublic ?? this.isPublic,
    imagePath: imagePath ?? this.imagePath,
    createdAt: createdAt ?? this.createdAt,
    creatorName: creatorName ?? this.creatorName,
    imageUrl: imageUrl ?? this.imageUrl,
  );

  factory CreateNewGroup.fromJson(Map<String, dynamic> json) =>
      _$CreateNewGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewGroupToJson(this);

  CreateNewGroupEntity toEntity() => CreateNewGroupEntity(
    id: id,
    name: name,
    description: description,
    subject: subject,
    createdBy: createdBy,
    members: members,
    isPublic: isPublic,
    imagePath: imagePath,
    createdAt: createdAt,
    creatorName: creatorName,
    imageUrl: imageUrl,
  );
}
