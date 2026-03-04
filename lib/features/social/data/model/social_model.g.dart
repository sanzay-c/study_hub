// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialModel _$SocialModelFromJson(Map<String, dynamic> json) => SocialModel(
  userId: json['user_id'] as String?,
  username: json['username'] as String?,
  avatarPath: json['avatar_path'] as String?,
  followers: json['followers'] as String?,
  following: json['following'] as String?,
  isFollowing: json['is_following'] as bool?,
  followedAt: json['followed_at'] == null
      ? null
      : DateTime.parse(json['followed_at'] as String),
);

Map<String, dynamic> _$SocialModelToJson(SocialModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'avatar_path': instance.avatarPath,
      'followers': instance.followers,
      'following': instance.following,
      'is_following': instance.isFollowing,
      'followed_at': instance.followedAt?.toIso8601String(),
    };
