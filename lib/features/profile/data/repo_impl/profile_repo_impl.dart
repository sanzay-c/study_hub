import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart';
import 'package:study_hub/features/profile/data/datasource/profile_datasource.dart';
import 'package:study_hub/features/profile/domain/repo/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDatasource profileDatasource;
  final AuthLocalDataSource authLocalDataSource;

  ProfileRepoImpl(this.profileDatasource, this.authLocalDataSource);

  @override
  Future<User> updateFullName(String fullName) async {
    try {
      final updatedUserModel = await profileDatasource.updateFullName(fullName);
      
      // Update local cache to ensure consistency across the app
      await authLocalDataSource.cacheUser(updatedUserModel);
      
      return updatedUserModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
