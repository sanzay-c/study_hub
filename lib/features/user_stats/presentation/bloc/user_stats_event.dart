part of 'user_stats_bloc.dart';

abstract class UserStatsEvent extends Equatable {
  const UserStatsEvent();

  @override
  List<Object?> get props => [];
}

class UserStatsFetched extends UserStatsEvent {
  final String? userId;

  const UserStatsFetched({this.userId});

  @override
  List<Object?> get props => [userId];
}
