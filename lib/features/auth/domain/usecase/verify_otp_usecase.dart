import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@injectable
class VerifyOTPUseCase {
  final AuthRepo repository;

  VerifyOTPUseCase(this.repository);

  Future<void> call(String email, String otp) async {
    return await repository.verifyOTP(email, otp);
  }
}
