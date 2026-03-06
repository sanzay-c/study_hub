import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';

part 'get_groups_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetGroupsModel {
  @JsonKey(name: '_id')
  String id;
  String? name;
  String? description;
  String? subject;
  String? createdBy;
  List<String>? members;
  bool? isPublic;
  DateTime? createdAt;
  String? creatorName;
  String? imageUrl;
  int? onlineCount;
  String? imagePath;

  GetGroupsModel({
    required this.id,
    this.name,
    this.description,
    this.subject,
    this.createdBy,
    this.members,
    this.isPublic,
    this.createdAt,
    this.creatorName,
    this.imageUrl,
    this.onlineCount,
    this.imagePath,
  });

  factory GetGroupsModel.fromJson(Map<String, dynamic> json) {
    return GetGroupsModel(
      id: json['_id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      subject: json['subject'] as String?,
      createdBy: json['created_by'] as String?,
      members: _parseMembers(json['members']),
      isPublic: json['is_public'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      creatorName: json['creator_name'] as String?,
      imageUrl: json['image_url'] as String?,
      onlineCount: (json['online_count'] as num?)?.toInt(),
      imagePath: json['image_path'] as String?,
    );
  }

  /// Safely parses members whether they are:
  /// - plain strings:  ["userId1", "userId2"]
  /// - user objects:   [{"_id": "userId1", "name": "John"}, ...]
  /// - null
  static List<String> _parseMembers(dynamic members) {
    if (members == null) return [];
    return (members as List<dynamic>)
        .map((e) {
          if (e is String) return e;
          if (e is Map) return e['_id']?.toString() ?? '';
          return e?.toString() ?? '';
        })
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Map<String, dynamic> toJson() => _$GetGroupsModelToJson(this);

  GetGroupsEntity toEntity() {
    return GetGroupsEntity(
      id: id,
      name: name,
      description: description,
      createdBy: createdBy,
      members: members ?? [],
      isPublic: isPublic ?? true,
      createdAt: createdAt ?? DateTime.now(),
      creatorName: creatorName,
      imageUrl: imageUrl,
      onlineCount: onlineCount ?? 0,
      imagePath: EnvConfig.resolveImageUrl(imagePath),
    );
  }

  GetGroupsModel copyWith({
    String? id,
    String? name,
    String? description,
    String? subject,
    String? createdBy,
    List<String>? members,
    bool? isPublic,
    DateTime? createdAt,
    String? creatorName,
    String? imageUrl,
    int? onlineCount,
    String? imagePath,
  }) => GetGroupsModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    subject: subject ?? this.subject,
    createdBy: createdBy ?? this.createdBy,
    members: members ?? this.members,
    isPublic: isPublic ?? this.isPublic,
    createdAt: createdAt ?? this.createdAt,
    creatorName: creatorName ?? this.creatorName,
    imageUrl: imageUrl ?? this.imageUrl,
    onlineCount: onlineCount ?? this.onlineCount,
    imagePath: imagePath ?? this.imagePath,
  );
}
