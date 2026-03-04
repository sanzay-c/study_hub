part of 'user_stats_cubit.dart';

abstract class UserStatsState {}

class UserStatsInitial extends UserStatsState {}

class UserStatsLoading extends UserStatsState {}

class UserStatsLoaded extends UserStatsState {
  final UserStatsEntity stats;
  UserStatsLoaded(this.stats);
}

class UserStatsError extends UserStatsState {
  final String message;
  UserStatsError(this.message);
}
