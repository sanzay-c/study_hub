import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';

part 'social_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SocialModel {
  @JsonKey(name: 'user_id')
  final String? userId;

  final String? username;

  final String? avatarPath;

  final String? followers;
  final String? following;
  final bool? isFollowing;
  final DateTime? followedAt;

  SocialModel({
    this.userId,
    this.username,
    this.avatarPath,
    this.followers,
    this.following,
    this.isFollowing,
    this.followedAt,
  });

  SocialModel copyWith({
    String? userId,
    String? username,
    String? avatarPath,
    String? followers,
    String? following,
    bool? isFollowing,
    DateTime? followedAt,
  }) =>
      SocialModel(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatarPath: avatarPath ?? this.avatarPath,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        isFollowing: isFollowing ?? this.isFollowing,
        followedAt: followedAt ?? this.followedAt,
      );

  factory SocialModel.fromJson(Map<String, dynamic> json) =>
      _$SocialModelFromJson(json);

  SocialEntity toEntity() {
    return SocialEntity(
      userId: userId ?? '',
      username: username ?? 'Unknown',
      avatarPath: EnvConfig.resolveImageUrl(avatarPath),
      followers: followers ?? '0',
      following: following ?? '0',
      isFollowing: isFollowing ?? false,
      followedAt: followedAt,
    );
  }
      
  Map<String, dynamic> toJson() => _$SocialModelToJson(this);

}