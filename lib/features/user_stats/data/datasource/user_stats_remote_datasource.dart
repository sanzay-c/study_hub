import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/user_stats/data/model/user_stats_model.dart';

abstract class UserStatsRemoteDataSource {
  Future<UserStatsModel> getMyStats();
  Future<UserStatsModel> getUserStatsById(String userId);
}

@LazySingleton(as: UserStatsRemoteDataSource)
class UserStatsRemoteDataSourceImpl implements UserStatsRemoteDataSource {
  final Dio _dio;

  UserStatsRemoteDataSourceImpl(this._dio);

  @override
  Future<UserStatsModel> getMyStats() async {
    try {
      final response = await _dio.get(ApiEndpoints.userStats);
      return UserStatsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserStatsModel> getUserStatsById(String userId) async {
    try {
      final response = await _dio.get(ApiEndpoints.userStatsId(userId));
      return UserStatsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
