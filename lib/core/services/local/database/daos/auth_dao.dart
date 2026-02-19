// lib/core/services/local/database/dao/auth_dao.dart

import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:study_hub/core/services/local/auth_database.dart';
import 'package:study_hub/core/services/local/database/table/auth_table.dart';

part 'auth_dao.g.dart';

@DriftAccessor(tables: [Users, AuthTokens])
class AuthDao extends DatabaseAccessor<AppDatabase> with _$AuthDaoMixin {
  AuthDao(super.db);

  /// Get current user 
  Future<User?> getCurrentUser() async {
    return await (select(users)..limit(1)).getSingleOrNull();
  }

  /// Get all users
  Future<List<User>> getAllUsers() {
    return select(users).get();
  }

  /// Insert or update user
  Future<void> saveUser(UsersCompanion user) async {
    await into(users).insertOnConflictUpdate(user);
  }

  /// Delete user by ID
  Future<void> deleteUserById(String userId) async {
    await (delete(users)..where((tbl) => tbl.id.equals(userId))).go();
  }

  /// Delete all users
  Future<void> deleteAllUsers() async {
    await delete(users).go();
  }

  /// Check if user exists
  Future<bool> userExists(String userId) async {
    final count = await (select(users)..where((tbl) => tbl.id.equals(userId)))
        .getSingleOrNull();
    return count != null;
  }

  /// Get current token 
  Future<AuthToken?> getCurrentToken() async {
    return await (select(authTokens)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Save new token 
  Future<void> saveToken(AuthTokensCompanion token) async {
    // Delete all old tokens
    await delete(authTokens).go();
    // Insert new token
    await into(authTokens).insert(token);
  }

  /// Delete all tokens
  Future<void> deleteAllTokens() async {
    await delete(authTokens).go();
  }

  /// Check if valid token exists
  Future<bool> hasValidToken() async {
    final token = await getCurrentToken();
    if (token == null) return false;

    // Check if token has expired
    if (token.expiresAt != null) {
      return token.expiresAt!.isAfter(DateTime.now());
    }

    return true;
  }


  /// Clear all auth data (logout)
  Future<void> clearAllAuthData() async {
    await delete(users).go();
    await delete(authTokens).go();
  }

  /// Get auth status (user and token both are checked)
  Future<bool> isAuthenticated() async {
    final user = await getCurrentUser();
    final hasToken = await hasValidToken();
    return user != null && hasToken;
  }


  /// Watch current user (real-time updates)
  Stream<User?> watchCurrentUser() {
    return (select(users)..limit(1)).watchSingleOrNull();
  }

  /// Watch current token (real-time updates)
  Stream<AuthToken?> watchCurrentToken() {
    return (select(authTokens)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Watch authentication status
  Stream<bool> watchAuthStatus() {
    return Rx.combineLatest2<User?, AuthToken?, bool>(
      watchCurrentUser(),
      watchCurrentToken(),
      (user, token) {
        if (user == null || token == null) return false;
        if (token.expiresAt != null) {
          return token.expiresAt!.isAfter(DateTime.now());
        }
        return true;
      },
    ).asBroadcastStream();
  }
}