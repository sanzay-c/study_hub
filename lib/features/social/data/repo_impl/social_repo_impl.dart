import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/data/datasource/social_remote_datasource.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/domain/entities/user_stats_entity.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@LazySingleton(as: SocialRepo)
class SocialRepoImpl implements SocialRepo {
  final SocialRemoteDataSource socialRemoteDataSource;

  SocialRepoImpl({required this.socialRemoteDataSource});

  @override
  Future<List<SocialEntity>> getSocialFollowing({String? search}) async {
    final result = await socialRemoteDataSource.getSocialFollowing(search: search);
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<SocialEntity>> getSocialFollowers({String? search}) async {
    final result = await socialRemoteDataSource.getSocialFollowers(search: search);
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<SocialEntity>> getSocialDiscover({String? search}) async {
    final result = await socialRemoteDataSource.getSocialDiscover(search: search);
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> followUser(String userId) async {
    await socialRemoteDataSource.followUser(userId);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await socialRemoteDataSource.unfollowUser(userId);
  }

  @override
  Future<UserStatsEntity> getUserStats(String userId) async {
    final result = await socialRemoteDataSource.getUserStats(userId);
    return result.toEntity();
  }
}
