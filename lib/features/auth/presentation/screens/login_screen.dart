import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/logo_container.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/auth/presentation/screens/request_reset_password_screen.dart';
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          CustomToast.show(
            context,
            message: 'Logged in Successfully! Welcome 🎉',
            type: ToastType.success,
          );

          context.read<MainBottomNavBloc>().add(const NavReset());

          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              getIt<NavigationService>().pushReplacementNamed(
                RouteName.bottomNavScreen,
              );
            }
          });
        } else if (state.status == AuthStatus.error &&
            state.submitError != null) {
          CustomToast.show(
            context,
            message: state.submitError!,
            type: ToastType.error,
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: getColorByTheme(
            context: context,
            colorClass: AppColors.backgroundColor,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(flex: 1),

                                LogoContainer(
                                  gradienColor: const [
                                    Color(0XFF526DFF),
                                    Color(0XFF8B32FB),
                                  ],
                                ),

                                30.verticalSpace,

                                TextWidget(
                                  text: 'Welcome Back',
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w800,
                                ),

                                16.verticalSpace,

                                TextWidget(
                                  text:
                                      'Sign in to continue your learning journey',
                                  textalign: TextAlign.center,
                                  color: const Color(0XFF4A5566),
                                  fontWeight: FontWeight.w600,
                                ),

                                24.verticalSpace,

                                const Row(
                                  children: [
                                    TextWidget(
                                      text: "Username",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),

                                8.verticalSpace,

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextFormField(
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                          UsernameChanged(value),
                                        );
                                      },
                                      initialValue: state.username,
                                      hintText: "Enter your username",
                                      svgIcon: SvgImageRenderWidget(
                                        svgImagePath: AssetsSource
                                            .authAssetsSource
                                            .authPersonIcon,
                                        height: 18.h,
                                        width: 18.w,
                                      ),
                                    ),
                                    if (state.usernameError != null) ...[
                                      4.verticalSpace,
                                      TextWidget(
                                        text: state.usernameError!,
                                        color: Colors.red,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ],
                                ),

                                24.verticalSpace,

                                const Row(
                                  children: [
                                    TextWidget(
                                      text: "Password",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),

                                8.verticalSpace,

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextFormField(
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                          PasswordChanged(value),
                                        );
                                      },
                                      initialValue: state.password,
                                      isPassword: true,
                                      hintText: "Enter your password",
                                      svgIcon: SvgImageRenderWidget(
                                        svgImagePath: AssetsSource
                                            .authAssetsSource
                                            .lockIcon,
                                        height: 18.h,
                                        width: 18.w,
                                      ),
                                    ),
                                    if (state.passwordError != null) ...[
                                      4.verticalSpace,
                                      TextWidget(
                                        text: state.passwordError!,
                                        color: Colors.red,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ],
                                ),

                                24.verticalSpace,

                                CommonButton(
                                  text: state.status == AuthStatus.loading
                                      ? "Signing in..."
                                      : "Sign in",
                                  onTap: state.status == AuthStatus.loading
                                      ? () {}
                                      : () {
                                          context.read<AuthBloc>().add(
                                            const LoginSubmitted(),
                                          );
                                        },
                                  color: const [
                                    Color(0XFF526DFF),
                                    Color(0XFF8B32FB),
                                  ],
                                  isLoading: state.status == AuthStatus.loading,
                                ),

                                32.verticalSpace,

                                GestureDetector(
                                  onTap: () {
                                    getIt<NavigationService>().pushNamed(RouteName.requestPasswordScreen);
                                  },
                                  child: TextWidget(
                                    text: 'Forgot Password ?',
                                    color: Color(0XFF1569FC),
                                  ),
                                ),

                                32.verticalSpace,

                                TextWidget(
                                  text: 'Don\'t have an account ? Sign Up',
                                  color: const Color(0XFF4A5566),
                                  fontSize: 16.sp,
                                  highlightText: 'Sign Up',
                                  highlightColor: const Color(0XFF1569FC),
                                  highlightFontWeight: FontWeight.w500,
                                  onHighlightTap: () =>
                                      getIt<NavigationService>()
                                          .pushReplacementNamed(
                                            RouteName.signUpScreen,
                                          ),
                                ),

                                40.verticalSpace,
                                const Spacer(flex: 1),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
