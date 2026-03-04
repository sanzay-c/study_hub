import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@injectable
class UnfollowUserUsecase {
  final SocialRepo repository;

  UnfollowUserUsecase({required this.repository});

  Future<void> call(String userId) {
    return repository.unfollowUser(userId);
  }
}
