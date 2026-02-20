import 'package:equatable/equatable.dart';
import 'package:study_hub/features/user_stats/domain/entities/group_stats.dart';

class UserStats extends Equatable {
  final String? email;
  final DateTime? joinedDate;
  final int? followers;
  final int? following;
  final GroupStats? groups;

  const UserStats({
    this.email,
    this.joinedDate,
    this.followers,
    this.following,
    this.groups,
  });

  @override
  List<Object?> get props => [
        email,
        joinedDate,
        followers,
        following,
        groups,
      ];
}