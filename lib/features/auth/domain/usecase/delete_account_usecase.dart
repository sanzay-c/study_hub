import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@lazySingleton
class DeleteAccountUseCase {
  final AuthRepo repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call(String password) async {
    return await repository.deleteAccount(password);
  }
}
