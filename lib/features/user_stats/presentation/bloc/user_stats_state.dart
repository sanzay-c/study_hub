part of 'user_stats_bloc.dart';

enum UserStatsStatus { initial, loading, success, error }

class UserStatsState extends Equatable {
  final UserStatsStatus status;
  final UserStats? stats;
  final String? errorMessage;

  const UserStatsState({
    this.status = UserStatsStatus.initial,
    this.stats,
    this.errorMessage,
  });

  UserStatsState copyWith({
    UserStatsStatus? status,
    UserStats? stats,
    String? errorMessage,
  }) {
    return UserStatsState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, stats, errorMessage];
}
