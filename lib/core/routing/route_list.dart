import 'package:flutter/material.dart';
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
import 'package:study_hub/features/groups/presentation/cubit/group_detail_cubit.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:study_hub/features/groups/presentation/widgets/empty_group.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
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
  GoRoute(
    path: RouteName.messagesScreen,
    name: RouteName.messagesScreen,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>? ?? {};
      final id = extra['id'] as String? ?? '';
      final isGroup = extra['isGroup'] as bool? ?? false;
      final title = extra['title'] as String? ?? 'Chat';

      return BlocProvider(
        create: (context) => getIt<ChatBloc>(),
        child: MessagesScreen(
          id: id,
          isGroup: isGroup,
          title: title,
        ),
      );
    },
  ),

  GoRoute(
    path: RouteName.groupDetailsScreen,
    name: RouteName.groupDetailsScreen,
    builder: (context, state) {
      final groupId = state.extra?.toString() ?? '';
      return BlocProvider(
        create: (context) => getIt<GroupDetailCubit>()..getGroupDetails(groupId),
        child: GroupDetailsScreen(groupId: groupId),
      );
    },
  ),

  customGoRoute(
    path: RouteName.socialScreen,
    child: SocialScreen(),
  ),

  GoRoute(
    path: RouteName.userDetailsScreen,
    name: RouteName.userDetailsScreen,
    pageBuilder: (context, state) {
      final user = state.extra as SocialEntity?;
      return MaterialPage(
        key: state.pageKey,
        child: user != null
            ? UserDetailsScreen(user: user)
            : const Scaffold(body: Center(child: Text('User not found'))),
      );
    },
  ),

  customGoRoute(path: RouteName.emptyGroupScreen, child: const EmptyGroup())


  // customGoRoute(
  //   path: RouteName.groupDetailsScreen,
  //   child: GroupDetailsScreen(),
  // ),
];

