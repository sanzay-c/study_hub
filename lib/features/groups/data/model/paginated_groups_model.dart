import 'package:json_annotation/json_annotation.dart';
import 'package:study_hub/features/groups/data/model/get_groups_model.dart';
import 'package:study_hub/features/groups/domain/entities/pagination_entity.dart';

part 'paginated_groups_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationModel {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  PaginationModel({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  PaginationEntity toEntity() => PaginationEntity(
    total: total,
    page: page,
    limit: limit,
    totalPages: totalPages,
    hasNext: hasNext,
    hasPrevious: hasPrevious,
  );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginatedGroupsModel {
  final List<GetGroupsModel> results;
  final PaginationModel pagination;

  PaginatedGroupsModel({
    required this.results,
    required this.pagination,
  });

  factory PaginatedGroupsModel.fromJson(Map<String, dynamic> json) => _$PaginatedGroupsModelFromJson(json);

  PaginatedGroupsEntity toEntity() => PaginatedGroupsEntity(
    results: results.map((e) => e.toEntity()).toList(),
    pagination: pagination.toEntity(),
  );
}
