import 'package:json_annotation/json_annotation.dart';
// Entity imports haru thapnus
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/core/config/env_config.dart';

part 'get_groups_detail_model.g.dart'; 

@JsonSerializable(fieldRename: FieldRename.snake)
class GetGroupsDetailModel {
  @JsonKey(name: "_id") 
  final String? id;
  final String? name;
  final String? description;
  final String? subject;
  final String? createdBy;
  final List<dynamic>? members;
  final bool? isPublic;
  final dynamic imagePath;
  final DateTime? createdAt;
  final String? creatorName;
  final dynamic imageUrl;
  final int? memberCount;
  final List<MembersPreview>? membersPreview;
  final List<dynamic>? notesPreview;
  final int? onlineCount;

  GetGroupsDetailModel({
    this.id,
    this.name,
    this.description,
    this.subject,
    this.createdBy,
    this.members,
    this.isPublic,
    this.imagePath,
    this.createdAt,
    this.creatorName,
    this.imageUrl,
    this.memberCount,
    this.membersPreview,
    this.notesPreview,
    this.onlineCount,
  });

  GetGroupsDetailEntity toEntity() => GetGroupsDetailEntity(
        id: id ?? '',
        name: name ?? '',
        description: description ?? '',
        subject: subject ?? '',
        createdBy: createdBy ?? '',
        members: _parseMembers(members),
        isPublic: isPublic ?? true,
        imagePath: EnvConfig.resolveImageUrl(imagePath?.toString()),
        createdAt: createdAt ?? DateTime.now(),
        creatorName: creatorName ?? '',
        imageUrl: EnvConfig.resolveImageUrl(imageUrl?.toString()),
        memberCount: memberCount ?? 0,
        membersPreview: membersPreview?.map((e) => e.toEntity()).toList() ?? [],
        notesPreview: notesPreview ?? [],
        onlineCount: onlineCount ?? 0,
      );

  static List<String> _parseMembers(dynamic members) {
    if (members == null) return [];
    return (members as List<dynamic>)
        .map((e) {
          if (e is String) return e;
          if (e is Map) return e['_id']?.toString() ?? e['id']?.toString() ?? '';
          return e?.toString() ?? '';
        })
        .where((e) => e.isNotEmpty)
        .toList();
  }

  factory GetGroupsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GetGroupsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGroupsDetailModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MembersPreview {
  final String? userId;
  final String? username;
  final String? fullname;
  final String? avatarPath; // String → String?
  final bool? isOnline;
  final bool? isOwner;

  MembersPreview({
    this.userId,
    this.username,
    this.fullname,
    this.avatarPath, // required हटा
    this.isOnline,
    this.isOwner,
  });

  MembersPreviewEntity toEntity() => MembersPreviewEntity(
        userId: userId ?? '',
        username: username ?? '',
        fullname: fullname ?? '',
        avatarPath: EnvConfig.resolveImageUrl(avatarPath), // Resolve image URL
        isOnline: isOnline ?? false,
        isOwner: isOwner ?? false,
      );

  factory MembersPreview.fromJson(Map<String, dynamic> json) =>
      _$MembersPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$MembersPreviewToJson(this);
}