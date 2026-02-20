import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/config/env_config.dart';
import 'package:study_hub/core/services/local/auth_database.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';
import 'package:study_hub/core/network/auth_interceptor.dart';

@module 
abstract class NetworkModule {
  @lazySingleton 
  Dio dio(AuthDao authDao) =>
      Dio(
        BaseOptions(
          baseUrl: EnvConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      )
        ..interceptors.addAll([
          AuthInterceptor(authDao), // Add our new token interceptor
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (obj) => log(obj.toString()),
          ),
        ]);

  @lazySingleton
  AppDatabase get database => AppDatabase();

  @lazySingleton
  AuthDao authDao(AppDatabase db) => db.authDao;
}
