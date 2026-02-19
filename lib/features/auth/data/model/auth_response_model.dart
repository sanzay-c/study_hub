import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/auth/data/model/auth_token_model.dart';
import 'package:study_hub/features/auth/data/model/user_model.dart';
import 'package:study_hub/features/auth/domain/entities/auth_response.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final AuthTokenModel token;
  final UserModel user;

  const AuthResponseModel({
    required this.token,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: AuthTokenModel.fromJson(json),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  AuthResponse toEntity() {
    return AuthResponse(
      token: token.toEntity(),
      user: user.toEntity(),
    );
  }

  factory AuthResponseModel.fromEntity(AuthResponse entity) {
    return AuthResponseModel(
      token: AuthTokenModel.fromEntity(entity.token),
      user: UserModel.fromEntity(entity.user),
    );
  }
}