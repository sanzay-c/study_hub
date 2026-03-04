import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/entities/user_stats_entity.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@injectable
class GetUserStatsUsecase {
  final SocialRepo repository;

  GetUserStatsUsecase(this.repository);

  Future<UserStatsEntity> call(String userId) {
    return repository.getUserStats(userId);
  }
}
