// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  fullname: json['fullname'] as String,
  avatarPath: json['avatar_path'] as String?,
  lastSeen: json['last_seen'] == null
      ? null
      : DateTime.parse(json['last_seen'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'fullname': instance.fullname,
  'avatar_path': instance.avatarPath,
  'last_seen': instance.lastSeen?.toIso8601String(),
};
