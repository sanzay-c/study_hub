import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/data/datasource/auth_datasource.dart';
import 'package:study_hub/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:study_hub/features/auth/domain/entities/auth_response.dart';
import 'package:study_hub/features/auth/domain/entities/signup_entity.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart'; 
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDatasource authDatasource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepoImpl(this.authDatasource, this.authLocalDataSource);

  @override
  Future<SignupEntity> signUp({
    required String username,
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final userRegister = await authDatasource.register(
        username: username,
        fullname: fullname,
        email: email,
        password: password,
      );
      return userRegister.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      log("🔵 REPO: Starting login...");
      final authResponseModel = await authDatasource.login(
        username: username,
        password: password,
      );
      log("🟢 REPO: Got response from API");

      //  PERSISTENCE: Save user and token to local database
      log("🔵 REPO: Caching user...");
      await authLocalDataSource.cacheUser(authResponseModel.user);
      log("🔵 REPO: Caching token...");
      await authLocalDataSource.cacheToken(authResponseModel.token);
      log("🟢 REPO: Cached successfully");

      log("🔵 REPO: Converting to entity...");
      final entity = authResponseModel.toEntity();
      log("🟢 REPO: Conversion successful");
      return entity;
    } catch (e, stackTrace) {
      log("🔴 REPO ERROR: $e");
      log("🔴 STACK TRACE: $stackTrace");
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final cachedUser = await authLocalDataSource.getCachedUser();
    return cachedUser?.toEntity();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await authLocalDataSource.isAuthenticated();
  }

  @override
  Future<void> logout() async {
    await authDatasource.logout();
    await authLocalDataSource.clearCache();
  }
}
