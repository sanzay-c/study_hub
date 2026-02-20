import 'package:json_annotation/json_annotation.dart';
import 'package:drift/drift.dart' as drift;
import 'package:study_hub/core/services/local/auth_database.dart' as db;
import 'package:study_hub/features/auth/domain/entities/user.dart' as entity;

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  @JsonKey(name: '_id')
  final String id;
  
  final String username;
  final String email;

  final String fullname;
  
  final String? avatarPath;
  
  final DateTime? lastSeen;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullname,
    this.avatarPath,
    this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  entity.User toEntity() {
    return entity.User(
      id: id,
      username: username,
      email: email,
      fullname: fullname,
      avatarPath: avatarPath,
      lastSeen: lastSeen,
    );
  }

  factory UserModel.fromEntity(entity.User entityUser) {
    return UserModel(
      id: entityUser.id,
      username: entityUser.username,
      email: entityUser.email,
      fullname: entityUser.fullname,
      avatarPath: entityUser.avatarPath,
      lastSeen: entityUser.lastSeen,
    );
  }

  // TO DRIFT COMPANION (for database)
  db.UsersCompanion toCompanion() {
    return db.UsersCompanion(
      id: drift.Value(id),
      username: drift.Value(username),
      email: drift.Value(email),
      fullname: drift.Value(fullname),
      avatarPath: drift.Value(avatarPath),
      lastSeen: drift.Value(lastSeen),
    );
  }

  factory UserModel.fromDrift(db.User driftUser) {
    return UserModel(
      id: driftUser.id,
      username: driftUser.username,
      email: driftUser.email,
      fullname: driftUser.fullname,
      avatarPath: driftUser.avatarPath,
      lastSeen: driftUser.lastSeen,
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? fullname,
    String? avatarPath,
    DateTime? lastSeen,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      avatarPath: avatarPath ?? this.avatarPath,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
