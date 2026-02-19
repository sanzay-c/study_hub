import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/features/auth/data/model/auth_response_model.dart';
import 'package:study_hub/features/auth/data/model/signup_model.dart';

@lazySingleton
class AuthDatasource {
  final Dio _dio;

  AuthDatasource(this._dio);

  Future<SignupModel> register({
    required String username,
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "username": username,
          "fullname": fullname,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return SignupModel.fromJson(response.data);
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

   Future<AuthResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        log("🟢 DATASOURCE: Got 200 response");
        log("🔵 DATASOURCE: Response data: ${response.data}");
        try {
          final authResponse = AuthResponseModel.fromJson(response.data);
          log("🟢 DATASOURCE: JSON parsing successful");
          return authResponse;
        } catch (parseError, parseStack) {
          log("🔴 DATASOURCE: JSON PARSE ERROR: $parseError");
          log("🔴 DATASOURCE: Parse stack: $parseStack");
          rethrow;
        }
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    } catch (e, stack) {
      log("🔴 DATASOURCE: Caught error: $e");
      log("🔴 DATASOURCE: Stack: $stack");
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      // Token is automatically added by AuthInterceptor
      await _dio.post(ApiEndpoints.logout);
      // No need to check status or parse response
      // Just fire and forget
    } catch (e) {
      // Even if API fails, we still logout locally
      // So we just log the error but don't throw
      log('⚠️ Server logout failed: $e');
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data != null && data is Map) {
        // If server returns {"message": "error here"}
        if (data.containsKey('message')) {
          return Exception(data['message']);
        }
        // If server returns {"email": ["Already taken"]} (common in Django)
        if (data.isNotEmpty) {
          final firstValue = data.values.first;
          if (firstValue is List && firstValue.isNotEmpty) {
            return Exception(firstValue.first.toString());
          }
          return Exception(data.toString());
        }
      }
      return Exception(error.message ?? "Network error");
    }
    return Exception("Unexpected error occurred");
  }
}
