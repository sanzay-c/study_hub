// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatsModel _$UserStatsModelFromJson(Map<String, dynamic> json) =>
    UserStatsModel(
      email: json['email'] as String,
      joinedDate: DateTime.parse(json['joined_date'] as String),
      followers: (json['followers'] as num).toInt(),
      following: (json['following'] as num).toInt(),
      groups: GroupStatsModel.fromJson(json['groups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserStatsModelToJson(UserStatsModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'joined_date': instance.joinedDate.toIso8601String(),
      'followers': instance.followers,
      'following': instance.following,
      'groups': instance.groups.toJson(),
    };
