import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/core/services/local/auth_database.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';

@module 
abstract class NetworkModule {
  @lazySingleton // Register Dio as singleton
  Dio get dio =>
      Dio(
          BaseOptions(
            baseUrl: EnvConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {"Content-Type": "application/json",  "Accept": "application/json",},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              log("Request: ${options.method} ${options.path}");
              return handler.next(options);
            },
            onResponse: (response, handler) {
              log("Response: ${response.statusCode}");
              return handler.next(response);
            },
            onError: (DioException e, handler) {
              log("Error: ${e.message}");
              return handler.next(e);
            },
          ),
        );

  @lazySingleton
  AppDatabase get database => AppDatabase();

  @lazySingleton
  AuthDao authDao(AppDatabase db) => db.authDao;
}
