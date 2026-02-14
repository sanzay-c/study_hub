import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRoute customGoRoute<T>({
  required String path,
  required Widget child,
  GoRouterWidgetBuilder? builder,
  List<RouteBase>? routes,
  GlobalKey<NavigatorState>? parentNavigatorKey,
  GoRouterPageBuilder? pageBuilder,
}) {
  return GoRoute(
    path: path,   // URL path
    name: path, // The name of the route (the path itself is used as the name)
    builder: builder, // If a builder is passed
    routes: routes ?? <RouteBase>[], // child routes
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: pageBuilder ??
        (context, state) => MaterialPage<T>(
              key: state.pageKey,
              name: state.name,
              child: child, // screen/widget
            ),
  );
}