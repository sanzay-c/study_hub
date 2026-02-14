import 'package:go_router/go_router.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_list.dart';
import 'package:study_hub/core/routing/route_name.dart';

final GoRouter router = GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      // initialLocation: RouteName.loginScreen,
      // initialLocation: RouteName.signUpScreen,
      // initialLocation: RouteName.bottomNavScreen,
      // initialLocation: RouteName.socialScreen,
      // initialLocation: RouteName.userDetailsScreen,
      // initialLocation: RouteName.groupDetailsScreen,
      // initialLocation: RouteName.messagesScreen,
      initialLocation: RouteName.initialSplashScreen, // ---** uncomment this later because when refresh it starts from login
      routes: [
        ...splashScreenRoutes,
        ...authScreenRoutes,
        ...bottomNavRoute,
        ...screensRoute,
      ],
    );
