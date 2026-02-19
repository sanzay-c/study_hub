import 'package:injectable/injectable.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';
import 'package:study_hub/features/auth/data/model/auth_token_model.dart';
import 'package:study_hub/features/auth/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> cacheToken(AuthTokenModel token);
  Future<UserModel?> getCachedUser();
  Future<AuthTokenModel?> getCachedToken();
  Future<void> clearCache();
  Future<bool> isAuthenticated();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AuthDao authDao;

  AuthLocalDataSourceImpl(this.authDao);

  @override
  Future<void> cacheUser(UserModel user) async {
    await authDao.saveUser(user.toCompanion());
  }

  @override
  Future<void> cacheToken(AuthTokenModel token) async {
    await authDao.saveToken(token.toCompanion());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final driftUser = await authDao.getCurrentUser();
    if (driftUser == null) return null;

    return UserModel.fromDrift(driftUser);
  }

  @override
  Future<AuthTokenModel?> getCachedToken() async {
    final driftToken = await authDao.getCurrentToken();
    if (driftToken == null) return null;

    return AuthTokenModel.fromDrift(driftToken);
  }

  @override
  Future<void> clearCache() async {
    await authDao.clearAllAuthData();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await authDao.isAuthenticated();
  }
}