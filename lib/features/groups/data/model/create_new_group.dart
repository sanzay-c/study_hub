import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';

part 'create_new_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateNewGroup {
  @JsonKey(
    name: '_id',
  ) // Specific name bhayeko le yeslai matra manually define garne
  final String id;

  final String name;
  final String description;
  final dynamic subject;
  final String createdBy; // Automatically maps to 'created_by'
  final List<String> members;
  final bool isPublic; // Automatically maps to 'is_public'
  final String imagePath; // Automatically maps to 'image_path'
  final DateTime createdAt; // Automatically maps to 'created_at'
  final String creatorName; // Automatically maps to 'creator_name'
  final String imageUrl; // Automatically maps to 'image_url'

  CreateNewGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.createdBy,
    required this.members,
    required this.isPublic,
    required this.imagePath,
    required this.createdAt,
    required this.creatorName,
    required this.imageUrl,
  });

  // copyWith method (Boilerplate low garna helpful hunchha)
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
