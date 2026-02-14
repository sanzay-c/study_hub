import 'package:go_router/go_router.dart';
import 'package:study_hub/common/splash_screen/chat_splash_screen.dart';
import 'package:study_hub/core/routing/custom_go_route.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/common/splash_screen/initial_splash_screen.dart';
import 'package:study_hub/common/splash_screen/network_splash_screen.dart';
import 'package:study_hub/features/auth/presentation/screens/login_screen.dart';
import 'package:study_hub/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:study_hub/features/bottom_nav/presentation/screen/study_hub_bottom_nav.dart';
import 'package:study_hub/features/chat/presentation/screens/messages_screen.dart';
import 'package:study_hub/features/groups/presentation/screens/group_details_screen.dart';
import 'package:study_hub/features/social/presentation/screens/social_screen.dart';
import 'package:study_hub/features/social/presentation/screens/user_details_screen.dart';

List<RouteBase> get splashScreenRoutes => [
  customGoRoute(
    path: RouteName.initialSplashScreen,
    child: const InitialSplashScreen(),
  ),
  customGoRoute(
    path: RouteName.secondSplashScreen,
    child: const ChatSplashScreen(),
  ),
  customGoRoute(
    path: RouteName.thirdSplashScreen,
    child: const NetworkSplashScreen(),
  ),
];

List<RouteBase> get authScreenRoutes => [
  customGoRoute(
    path: RouteName.loginScreen,
    child: LoginScreen(),
  ),
  customGoRoute(
    path: RouteName.signUpScreen,
    child: SignUpScreen(),
  ),
];

List<RouteBase> get bottomNavRoute => [
  customGoRoute(
    path: RouteName.bottomNavScreen,
    child: StudyHubBottomNav(),
  ),
];

List<RouteBase> get screensRoute => [
  customGoRoute(
    path: RouteName.messagesScreen,
    child: MessagesScreen(),
  ),

  customGoRoute(
    path: RouteName.groupDetailsScreen,
    child: GroupDetailsScreen(),
  ),

  customGoRoute(
    path: RouteName.socialScreen,
    child: SocialScreen(),
  ),

  customGoRoute(
    path: RouteName.userDetailsScreen,
    child: UserDetailsScreen(),
  ),
];

