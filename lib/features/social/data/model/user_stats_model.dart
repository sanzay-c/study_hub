import 'package:study_hub/features/social/domain/entities/user_stats_entity.dart';

class UserStatsModel {
  final String? email;
  final DateTime? joinedDate;

  UserStatsModel({
    this.email,
    this.joinedDate,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      email: json['email'] as String?,
      joinedDate: json['joined_date'] != null
          ? DateTime.tryParse(json['joined_date'] as String)
          : null,
    );
  }

  UserStatsEntity toEntity() => UserStatsEntity(
        email: email,
        joinedDate: joinedDate,
      );
}
