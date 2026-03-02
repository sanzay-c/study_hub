import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/groups/data/model/groups_model.dart';

abstract class GroupsRemoteDataSource {
  Future<List<GroupsModel>> getGroups();
}

@LazySingleton(as: GroupsRemoteDataSource)
class GroupsRemoteDataSourceImpl implements GroupsRemoteDataSource {
  final Dio dio;

  GroupsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GroupsModel>> getGroups() async {
    final response = await dio.get(ApiEndpoints.getGroups);
    
    dynamic data;
    if (response.data is List) {
      data = response.data;
    } else if (response.data is Map && response.data['groups'] is List) {
      data = response.data['groups'];
    } else if (response.data is Map && response.data['data'] is List) {
      data = response.data['data'];
    } else {
      throw Exception('Invalid groups response format');
    }

    return (data as List)
        .map((e) => GroupsModel.fromJson(e))
        .toList();
  }
}
