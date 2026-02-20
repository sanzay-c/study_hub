import 'package:dio/dio.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';

class AuthInterceptor extends Interceptor {
  final AuthDao _authDao;

  AuthInterceptor(this._authDao);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Get the token from local database
    final tokenModel = await _authDao.getCurrentToken();

    if (tokenModel != null && tokenModel.accessToken.isNotEmpty) {
      // 2. Add the Bearer token to headers
      options.headers['Authorization'] = 'Bearer ${tokenModel.accessToken}';
    }

    return handler.next(options);
  }
}
