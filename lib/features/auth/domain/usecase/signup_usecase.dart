import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/entities/signup_entity.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class SignupUsecase {
  final AuthRepo authRepo;

  SignupUsecase({required this.authRepo});

  Future<SignupEntity> call({
    required String username,
    required String fullname,
    required String email,
    required String password,
  }) async {
    return await authRepo.signUp(
      username: username,
      fullname: fullname,
      email: email,
      password: password,
    );
  }
}
