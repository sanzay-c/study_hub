import 'package:equatable/equatable.dart';
import 'package:study_hub/features/auth/domain/entities/auth_token.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart';

class AuthResponse extends Equatable {
  final AuthToken token;
  final User user;

  const AuthResponse({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}