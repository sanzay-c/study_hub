import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return await repository.resetPassword(email, otp, newPassword);
  }
}
