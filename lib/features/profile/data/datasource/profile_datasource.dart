import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/auth/data/model/user_model.dart';

@lazySingleton
class ProfileDatasource {
  final Dio _dio;

  ProfileDatasource(this._dio);

  Future<UserModel> updateFullName(String fullName) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.updateUserFullName,
        data: {'fullname': fullName},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Failed to update full name: ${response.statusCode}");
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data != null && data is Map) {
        if (data.containsKey('error')) {
          return Exception(data['error']);
        }
        if (data.containsKey('message')) {
          return Exception(data['message']);
        }
      }
      return Exception(error.message ?? "Network error occurred");
    }
    return Exception(error.toString());
  }
}
