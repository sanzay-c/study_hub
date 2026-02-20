// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupStatsModel _$GroupStatsModelFromJson(Map<String, dynamic> json) =>
    GroupStatsModel(
      total: (json['total'] as num).toInt(),
      created: (json['created'] as num).toInt(),
      joined: (json['joined'] as num).toInt(),
    );

Map<String, dynamic> _$GroupStatsModelToJson(GroupStatsModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'created': instance.created,
      'joined': instance.joined,
    };
