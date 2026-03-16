import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/global_data/global_theme/bloc/theme_bloc.dart';
import 'package:study_hub/core/network/internet/cubit/connectivity_cubit.dart';
import 'package:study_hub/core/network/internet/screens/widget/connectivity_wrapper.dart';
import 'package:study_hub/core/routing/router_config.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart';
import 'package:study_hub/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:study_hub/features/groups/presentation/cubit/create_group_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:study_hub/features/notes/presentation/cubit-upload-note/upload_note_cubit.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/upload_avatar/presentation/cubit/upload_avatar_cubit.dart';
import 'package:study_hub/features/user_stats/presentation/bloc/user_stats_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // BlocProvider(
            //   create: (context) => RecipeBloc(
            //     recipeUsecase: RecipeUsecase(
            //       recipeRepo: RecipeRepoImpl(datasource: RecipeDatasource()),
            //     ),
            //   ),
            // ),
            BlocProvider(create: (_) => getIt<ThemeBloc>()),
            BlocProvider(create: (_) => getIt<AuthBloc>()),
            BlocProvider(create: (_) => getIt<SocialBloc>()),
            BlocProvider(create: (_) => getIt<UploadAvatarCubit>()),
            BlocProvider(create: (_) => getIt<UserStatsBloc>()),
            BlocProvider(create: (_) => getIt<NotesBloc>()),
            BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
            BlocProvider(create: (_) => getIt<MainBottomNavBloc>()),
            BlocProvider(create: (_) => getIt<GroupsCubit>()),
            BlocProvider(create: (_) => getIt<CreateGroupCubit>()),
            BlocProvider(create: (_) => getIt<UploadNoteCubit>()),
            BlocProvider(create: (_) => getIt<ChatBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode,
                theme: ThemeData(
                  fontFamily: 'Nunito',
                  brightness: Brightness.light, // Light theme
                ),
                darkTheme: ThemeData(
                  fontFamily: 'Nunito',
                  brightness: Brightness.dark, // Dark theme
                ),
                routerConfig: router,
                builder: (context, child) {
                  return ConnectivityWrapper(
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
