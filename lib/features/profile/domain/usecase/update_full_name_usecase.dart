import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart';
import 'package:study_hub/features/profile/domain/repo/profile_repo.dart';

@lazySingleton
class UpdateFullNameUseCase {
  final ProfileRepo repository;

  UpdateFullNameUseCase(this.repository);

  Future<User> call(String fullName) async {
    return await repository.updateFullName(fullName);
  }
}
