// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      hasNext: json['has_next'] as bool,
      hasPrevious: json['has_previous'] as bool,
    );

// ignore: unused_element
Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'total_pages': instance.totalPages,
      'has_next': instance.hasNext,
      'has_previous': instance.hasPrevious,
    };

PaginatedGroupsModel _$PaginatedGroupsModelFromJson(
  Map<String, dynamic> json,
) => PaginatedGroupsModel(
  results: (json['results'] as List<dynamic>)
      .map((e) => GetGroupsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: PaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

// ignore: unused_element
Map<String, dynamic> _$PaginatedGroupsModelToJson(
  PaginatedGroupsModel instance,
) => <String, dynamic>{
  'results': instance.results,
  'pagination': instance.pagination,
};
