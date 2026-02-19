import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/global_data/global_theme/bloc/theme_bloc.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/about_card_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/account_card_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/appearance_card_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/logout_card_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/profile_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(title: "Profile"),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.initial) {
            
            CustomToast.show(
              context,
              message: 'Logout Successfull! See you soon 👋',
              type: ToastType.success,
              duration: const Duration(seconds: 3),
            );

            getIt<NavigationService>().pushReplacementNamed(
              RouteName.loginScreen,
            );
            
          } else if (state.status == AuthStatus.error &&
              state.submitError != null) {
            CustomToast.show(
              context,
              message: state.submitError!,
              type: ToastType.error,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = state.user;
                    return ProfileCardWidget(
                      username: user?.username ?? 'Guest',
                      fullname: user?.fullname ?? 'Study Hub User',
                      bio: 'Student | lifelong learner',
                      followers: 42,
                      following: 38,
                      groups: 8,
                      onEditProfile: () {},
                      onCameraIconTap: () {},
                    );
                  },
                ),
                16.verticalSpace,
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    final isDarkTheme = state is DarkThemeState;
                    return AppearanceCardWidget(
                      title: 'Appearance',
                      label: isDarkTheme ? 'Dark Mode' : 'Light Mode',
                      value: isDarkTheme,
                      activeIcon: AssetsSource.appIcons.moonIcon,
                      inactiveIcon: AssetsSource.appIcons.sunIcon,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    );
                  },
                ),
                16.verticalSpace,
                AccountCardWidget(label: "Account"),
                16.verticalSpace,
                AboutCardWidget(label: 'About'),
                16.verticalSpace,
                LogoutCardWidget(
                  label: 'Logout',
                  onTap: () {
                    context.read<AuthBloc>().add(const LogoutRequested());
                  },
                ),
                24.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
