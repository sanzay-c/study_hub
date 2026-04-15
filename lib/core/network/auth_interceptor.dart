import 'package:drift/drift.dart';
import 'package:dio/dio.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/core/network/api_endpoints.dart';
import 'package:study_hub/core/services/local/auth_database.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';

class AuthInterceptor extends Interceptor {
  final AuthDao _authDao;

  // Flag to check if a refresh operation is already in progress
  bool _isRefreshing = false;

  // List to queue requests that failed with 401 while refreshing
  final List<_RetryRequest> _requestQueue = [];

  AuthInterceptor(this._authDao);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenModel = await _authDao.getCurrentToken();

    if (tokenModel != null && tokenModel.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${tokenModel.accessToken}';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 1. Check if it's a 401 Unauthorized error
    if (err.response?.statusCode == 401) {
      final tokenModel = await _authDao.getCurrentToken();

      // If we have a refresh token, try to refresh
      if (tokenModel != null && tokenModel.refreshToken.isNotEmpty) {
        
        // If already refreshing, add this request to the queue
        if (_isRefreshing) {
          _requestQueue.add(_RetryRequest(err.requestOptions, handler));
          return;
        }

        _isRefreshing = true;

        try {
          // Perform the refresh request
          final dio = Dio(BaseOptions(baseUrl: EnvConfig.apiBaseUrl));
          final response = await dio.post(
            ApiEndpoints.refreshToken,
            data: {'refresh': tokenModel.refreshToken},
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final newAccessToken = response.data['access'];
            final newRefreshToken = response.data['refresh'];

            // Save new tokens
            await _authDao.saveToken(
              AuthTokensCompanion(
                accessToken: Value(newAccessToken),
                refreshToken: Value(newRefreshToken),
                createdAt: Value(DateTime.now()),
              ),
            );

            _isRefreshing = false;

            // Retry the original request that triggered the refresh
            final retryResponse = await _retry(err.requestOptions, newAccessToken);
            handler.resolve(retryResponse);

            // Retry all other requests in the queue
            for (var request in _requestQueue) {
              final res = await _retry(request.options, newAccessToken);
              request.handler.resolve(res);
            }
            _requestQueue.clear();
            return;
          }
        } on DioException catch (e) {
          _isRefreshing = false;
          _requestQueue.clear();
          
          // Only clear data/logout if the refresh token itself is invalid (401 or 403)
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await _authDao.clearAllAuthData();
          }
        }
      }
    }

    return super.onError(err, handler);
  }

  /// Helper method to retry a failed request with the new access token
  Future<Response> _retry(RequestOptions requestOptions, String token) {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return Dio().request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

/// Private class to hold the request options and handler for queued requests
class _RetryRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _RetryRequest(this.options, this.handler);
}
