import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/entities/auth_response.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@injectable
class LoginUsecase {
  final AuthRepo repository;

  LoginUsecase(this.repository);

  Future<AuthResponse> call({
    required String username,
    required String password,
  }) async {
    return await repository.login(username: username, password: password);
  }
}
