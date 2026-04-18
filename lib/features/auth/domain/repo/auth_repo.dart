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

  Future<User> updateAvatar(String filePath);
  
  Future<void> updateFcmToken(String token);
  
  Future<void> requestReset(String email);
  Future<void> verifyOTP(String email, String otp);
  Future<void> resetPassword(String email, String otp, String newPassword);
  
  Future<void> deleteAccount(String password);
}
