// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/user_stats/domain/entities/user_stats.dart';
import 'package:study_hub/features/user_stats/domain/usecase/get_user_stats_usecase.dart';

part 'user_stats_event.dart';
part 'user_stats_state.dart';

@injectable
class UserStatsBloc extends Bloc<UserStatsEvent, UserStatsState> {
  final GetUserStatsUseCase _getUserStatsUseCase;

  UserStatsBloc(this._getUserStatsUseCase) : super(const UserStatsState()) {
    on<UserStatsFetched>(_onUserStatsFetched);
  }

  Future<void> _onUserStatsFetched(
    UserStatsFetched event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserStatsStatus.loading));

      final stats = await _getUserStatsUseCase(userId: event.userId);

      emit(state.copyWith(
        status: UserStatsStatus.success,
        stats: stats,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserStatsStatus.error,
        errorMessage: "Failed to fetch user statistics",
      ));
    }
  }
}
