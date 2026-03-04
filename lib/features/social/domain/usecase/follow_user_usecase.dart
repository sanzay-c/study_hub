import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@injectable
class FollowUserUsecase {
  final SocialRepo repository;

  FollowUserUsecase({required this.repository});

  Future<void> call(String userId) {
    return repository.followUser(userId);
  }
}
