import 'package:injectable/injectable.dart';
import 'package:study_hub/features/user_stats/data/datasource/user_stats_remote_datasource.dart';
import 'package:study_hub/features/user_stats/domain/entities/user_stats.dart';
import 'package:study_hub/features/user_stats/domain/repo/user_stats_repository.dart';

@LazySingleton(as: UserStatsRepository)
class UserStatsRepositoryImpl implements UserStatsRepository {
  final UserStatsRemoteDataSource _remoteDataSource;

  UserStatsRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserStats> getMyStats() async {
    try {
      final model = await _remoteDataSource.getMyStats();
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserStats> getUserStatsById(String userId) async {
    try {
      final model = await _remoteDataSource.getUserStatsById(userId);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
