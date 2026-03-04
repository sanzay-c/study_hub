import 'package:study_hub/features/social/domain/entities/social_entity.dart';

abstract class SocialRepo {
  Future<List<SocialEntity>> getSocialFollowing({String? search});
  Future<List<SocialEntity>> getSocialFollowers({String? search});
  Future<List<SocialEntity>> getSocialDiscover({String? search});
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
}