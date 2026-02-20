import 'package:study_hub/features/user_stats/domain/entities/user_stats.dart';

abstract class UserStatsRepository {
  Future<UserStats> getMyStats();
  Future<UserStats> getUserStatsById(String userId);
}
