import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/entities/user_stats_entity.dart';
import 'package:study_hub/features/social/domain/usecase/get_user_stats_usecase.dart';

part 'user_stats_state.dart';

@injectable
class UserStatsCubit extends Cubit<UserStatsState> {
  final GetUserStatsUsecase getUserStatsUsecase;

  UserStatsCubit(this.getUserStatsUsecase) : super(UserStatsInitial());

  Future<void> fetchStats(String userId) async {
    emit(UserStatsLoading());
    try {
      final stats = await getUserStatsUsecase(userId);
      emit(UserStatsLoaded(stats));
    } catch (e) {
      emit(UserStatsError(e.toString()));
    }
  }
}
