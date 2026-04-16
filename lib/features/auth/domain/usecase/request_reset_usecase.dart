import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@injectable
class RequestResetUseCase {
  final AuthRepo repository;

  RequestResetUseCase(this.repository);

  Future<void> call(String email) async {
    return await repository.requestReset(email);
  }
}
