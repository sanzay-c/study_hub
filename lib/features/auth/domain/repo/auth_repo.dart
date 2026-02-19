import 'package:study_hub/features/auth/domain/entities/user.dart';
import 'package:study_hub/features/auth/domain/entities/auth_response.dart';
import 'package:study_hub/features/auth/domain/entities/signup_entity.dart';

abstract class AuthRepo {
  Future<SignupEntity> signUp({
    required String username,
    required String fullname,
    required String email,
    required String password,
  });

  Future<AuthResponse> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<bool> isAuthenticated();
}
