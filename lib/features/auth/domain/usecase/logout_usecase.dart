import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@injectable
class LogoutUsecase {
  final AuthRepo repository;

  LogoutUsecase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
