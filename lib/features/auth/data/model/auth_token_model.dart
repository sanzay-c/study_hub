import 'package:json_annotation/json_annotation.dart';
import 'package:drift/drift.dart' as drift;
import 'package:study_hub/core/services/local/auth_database.dart' as db;
import 'package:study_hub/features/auth/domain/entities/auth_token.dart' as entity;

part 'auth_token_model.g.dart';

@JsonSerializable()
class AuthTokenModel {
  @JsonKey(name: 'access')
  final String accessToken;

  @JsonKey(name: 'refresh')
  final String refreshToken;

  const AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);

  entity.AuthToken toEntity() {
    return entity.AuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      id: null,
      createdAt: null,
    );
  }

  factory AuthTokenModel.fromEntity(entity.AuthToken entityToken) {
    return AuthTokenModel(
      accessToken: entityToken.accessToken,
      refreshToken: entityToken.refreshToken,
    );
  }

  // TO DRIFT COMPANION (for database)
  db.AuthTokensCompanion toCompanion() {
    return db.AuthTokensCompanion(
      accessToken: drift.Value(accessToken),
      refreshToken: drift.Value(refreshToken),
    );
  }

  factory AuthTokenModel.fromDrift(db.AuthToken driftToken) {
    return AuthTokenModel(
      accessToken: driftToken.accessToken,
      refreshToken: driftToken.refreshToken,
    );
  }
}