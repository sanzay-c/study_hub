import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/core/routing/router_config.dart';

@lazySingleton
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get ctx =>
      router.routerDelegate.navigatorKey.currentContext;

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) =>
      ctx!.pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void pop<T extends Object?>([T? result]) => ctx!.pop(result);

  bool canPop() => ctx!.canPop();

  void pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) =>
      ctx!.pushReplacementNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  BuildContext getNavigationContext() => ctx!;
}
