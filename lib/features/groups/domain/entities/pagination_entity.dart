import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';

class PaginationEntity {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  PaginationEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });
}

class PaginatedGroupsEntity {
  final List<GetGroupsEntity> results;
  final PaginationEntity pagination;

  PaginatedGroupsEntity({
    required this.results,
    required this.pagination,
  });
}
