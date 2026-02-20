import 'package:injectable/injectable.dart';
import 'package:study_hub/features/user_stats/domain/entities/user_stats.dart';
import 'package:study_hub/features/user_stats/domain/repo/user_stats_repository.dart';

@lazySingleton
class GetUserStatsUseCase {
  final UserStatsRepository _repository;

  GetUserStatsUseCase(this._repository);

  Future<UserStats> call({String? userId}) {
    if (userId == null || userId.isEmpty || userId == "me") {
       return _repository.getMyStats();
    }
    return _repository.getUserStatsById(userId);
  }
}
