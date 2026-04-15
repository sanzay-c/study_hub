import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/groups/data/model/create_new_group.dart';
import 'package:study_hub/features/groups/data/model/get_groups_detail_model.dart';
import 'package:study_hub/features/groups/data/model/get_groups_model.dart';
import 'package:study_hub/features/groups/data/model/groups_model.dart';
import 'package:study_hub/features/groups/data/model/paginated_groups_model.dart';

abstract class GroupsRemoteDataSource {
  Future<List<GroupsModel>> getGroups();
  Future<PaginatedGroupsModel> getAllGroups({String? tab, int page = 1, int limit = 50});
  Future<GetGroupsDetailModel> getGroupDetails(String groupId);
  Future<CreateNewGroup> createGroup(
    Map<String, dynamic> groupData, {
    XFile? image,
  });
  Future<void> joinGroup(String groupId);
  Future<void> leaveGroup(String groupId);
  Future<CreateNewGroup> updateGroup(
    String groupId,
    Map<String, dynamic> groupData, {
    XFile? image,
  });
  Future<void> deleteGroup(String groupId);
  Future<void> removeMember(String groupId, String userId);
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
    } else if (response.data is Map && response.data['results'] is List) {
      // New paginated format
      data = response.data['results'];
    } else if (response.data is Map && response.data['groups'] is List) {
      data = response.data['groups'];
    } else if (response.data is Map && response.data['data'] is List) {
      data = response.data['data'];
    } else {
      throw Exception('Invalid groups response format');
    }

    return (data as List).map((e) => GroupsModel.fromJson(e)).toList();
  }

  @override
  Future<PaginatedGroupsModel> getAllGroups({String? tab, int page = 1, int limit = 50}) async {
    final Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
    if (tab != null) queryParams['tab'] = tab;

    final response = await dio.get(
      ApiEndpoints.getAllGroups,
      queryParameters: queryParams,
    );

    if (response.data is Map && response.data['results'] is List) {
      return PaginatedGroupsModel.fromJson(response.data);
    } else if (response.data is List) {
      // Fallback for old direct list format
      return PaginatedGroupsModel(
        results: (response.data as List).map((e) => GetGroupsModel.fromJson(e)).toList(),
        pagination: PaginationModel(
          total: (response.data as List).length,
          page: 1,
          limit: limit,
          totalPages: 1,
          hasNext: false,
          hasPrevious: false,
        ),
      );
    } else {
      throw Exception('Invalid groups response format');
    }
  }

  @override
  Future<GetGroupsDetailModel> getGroupDetails(String groupId) async {
    // API endpoint call garne. groupId lai URL string ma inject garnu parcha.
    final response = await dio.get(ApiEndpoints.getGroupsDetail(groupId));

    if (response.statusCode == 200) {
      // Dio le response.data lai automatically Map ma convert gari sakeko huncha
      final dynamic responseData = response.data;

      // Response structure herera handle garne (if wrap bhako cha bhane)
      final data = (responseData is Map && responseData.containsKey('data'))
          ? responseData['data']
          : responseData;

      return GetGroupsDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load group details');
    }
  }

  @override
  Future<CreateNewGroup> createGroup(
    Map<String, dynamic> groupData, {
    XFile? image,
  }) async {
    dynamic body;

    if (image != null) {
      body = FormData.fromMap({
        ...groupData,
        'image': await MultipartFile.fromFile(image.path, filename: image.name),
      });
    } else {
      body = groupData;
    }

    final response = await dio.post(ApiEndpoints.createNewGroup, data: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = response.data;

      final data = (responseData is Map && responseData.containsKey('data'))
          ? responseData['data']
          : responseData;

      return CreateNewGroup.fromJson(data);
    } else {
      throw Exception('Failed to create group');
    }
  }

  @override
  Future<void> joinGroup(String groupId) async {
    final response = await dio.post(ApiEndpoints.joinGroup(groupId));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to join group');
    }
  }

  @override
  Future<void> leaveGroup(String groupId) async {
    final response = await dio.post(ApiEndpoints.leaveGroup(groupId));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to leave group');
    }
  }

  @override
  Future<CreateNewGroup> updateGroup(
    String groupId,
    Map<String, dynamic> groupData, {
    XFile? image,
  }) async {
    dynamic body;

    // Update garda pani image huna sakne bhayeko le FormData handle garne
    if (image != null) {
      body = FormData.fromMap({
        ...groupData,
        'image': await MultipartFile.fromFile(image.path, filename: image.name),
      });
    } else {
      body = groupData;
    }

    // PATCH method use garne partial update ko lagi
    final response = await dio.patch(
      ApiEndpoints.updateGroup(groupId),
      data: body,
    );

    if (response.statusCode == 200) {
      final dynamic responseData = response.data;
      final data = (responseData is Map && responseData.containsKey('data'))
          ? responseData['data']
          : responseData;

      return CreateNewGroup.fromJson(data);
    } else {
      throw Exception('Failed to update group');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    // DELETE method call garne
    final response = await dio.delete(ApiEndpoints.deleteGroup(groupId));

    // Delete ma hami dherai jaso 200 or 204 (No Content) status code check garchhau
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete group');
    }
  }

  @override
  Future<void> removeMember(String groupId, String userId) async {
   
    final response = await dio.post(
      ApiEndpoints.removeMember(groupId),
      data: {
        'user_id':
            userId,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to remove member from group');
    }
  }
}
