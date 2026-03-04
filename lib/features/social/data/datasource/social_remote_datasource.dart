import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/social/data/model/social_model.dart';
import 'package:study_hub/features/social/data/model/user_stats_model.dart';

abstract class SocialRemoteDataSource {
  Future<List<SocialModel>> getSocialFollowing({String? search});
  Future<List<SocialModel>> getSocialFollowers({String? search});
  Future<List<SocialModel>> getSocialDiscover({String? search});
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<UserStatsModel> getUserStats(String userId);
}

@LazySingleton(as: SocialRemoteDataSource)
class SocialRemoteDataSourceImpl implements SocialRemoteDataSource {
  final Dio dio;

  SocialRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SocialModel>> getSocialFollowing({String? search}) async {
    final response = await dio.get(
      ApiEndpoints.socialFollowing,
      queryParameters: search != null && search.isNotEmpty ? {'search': search} : null,
    );
    return (response.data as List)
        .map((e) => SocialModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<SocialModel>> getSocialFollowers({String? search}) async {
    final response = await dio.get(
      ApiEndpoints.socialFollowers,
      queryParameters: search != null && search.isNotEmpty ? {'search': search} : null,
    );
    return (response.data as List)
        .map((e) => SocialModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<SocialModel>> getSocialDiscover({String? search}) async {
    final response = await dio.get(
      ApiEndpoints.socialDiscover,
      queryParameters: search != null && search.isNotEmpty ? {'search': search} : null,
    );
    return (response.data as List)
        .map((e) => SocialModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> followUser(String userId) async {
    await dio.post(
      ApiEndpoints.socialFollow,
      data: {'user_id': userId},
    );
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await dio.delete(
      ApiEndpoints.socialUnfollow,
      data: {'user_id': userId},
    );
  }
  
  @override
  Future<UserStatsModel> getUserStats(String userId) async {
    final response = await dio.get(ApiEndpoints.userStatsId(userId));
    return UserStatsModel.fromJson(response.data as Map<String, dynamic>);
  }
}