import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/user_stats/domain/entities/group_stats.dart';

part 'group_stats_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GroupStatsModel {
  final int total;
  final int created;
  final int joined;

  const GroupStatsModel({
    required this.total,
    required this.created,
    required this.joined,
  });

  // ========== FROM JSON ==========
  factory GroupStatsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupStatsModelFromJson(json);

  // ========== TO JSON ==========
  Map<String, dynamic> toJson() => _$GroupStatsModelToJson(this);

  // ========== TO ENTITY ========== ✅
  GroupStats toEntity() {
    return GroupStats(
      total: total,
      created: created,
      joined: joined,
    );
  }

  // ========== FROM ENTITY ========== ✅
  factory GroupStatsModel.fromEntity(GroupStats entity) {
    return GroupStatsModel(
      total: entity.total ?? 0,
      created: entity.created ?? 0,
      joined: entity.joined ?? 0,
    );
  }
}