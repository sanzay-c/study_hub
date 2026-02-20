import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/user_stats/data/model/group_stats_model.dart';
import 'package:study_hub/features/user_stats/domain/entities/group_stats.dart';
import 'package:study_hub/features/user_stats/domain/entities/user_stats.dart';

part 'user_stats_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserStatsModel {
  final String email;
  final DateTime joinedDate;
  
  final int followers;
  final int following;
  final GroupStatsModel groups;

  const UserStatsModel({
    required this.email,
    required this.joinedDate,
    required this.followers,
    required this.following,
    required this.groups,
  });

  // ========== FROM JSON ==========
  factory UserStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatsModelFromJson(json);

  // ========== TO JSON ==========
  Map<String, dynamic> toJson() => _$UserStatsModelToJson(this);

  // ========== TO ENTITY ========== ✅
  UserStats toEntity() {
    return UserStats(
      email: email,
      joinedDate: joinedDate,
      followers: followers,
      following: following,
      groups: groups.toEntity(),
    );
  }

  // ========== FROM ENTITY ========== ✅
  factory UserStatsModel.fromEntity(UserStats entity) {
    return UserStatsModel(
      email: entity.email ?? '',
      joinedDate: entity.joinedDate ?? DateTime.now(),
      followers: entity.followers ?? 0,
      following: entity.following ?? 0,
      groups: GroupStatsModel.fromEntity(
        entity.groups ?? const GroupStats(),
      ),
    );
  }
}



// [log] Request: GET /api/auth/me/stats/
// [log] Error: This exception was thrown because the response has a status code of 401 and RequestOptions.validateStatus was configured to throw for this status code.
//       The status code of 401 has the following meaning: "Client error - the request contains bad syntax or cannot be fulfilled"
//       Read more about status codes at https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
//       In order to resolve this exception you typically have either to verify and fix your request code or you have to fix the server code.


// why am i seeing this /api/auth/me/stats/ uses beare token isnt it ?
// has the bearer token to be written it in dio ?