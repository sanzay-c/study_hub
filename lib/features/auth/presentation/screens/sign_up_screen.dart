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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          CustomToast.show(
            context,
            message: 'Account created successfully! Welcome aboard 🎉',
            type: ToastType.success,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            getIt<NavigationService>().pushReplacementNamed(
              RouteName.bottomNavScreen,
            );
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
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: getColorByTheme(
            context: context,
            colorClass: AppColors.backgroundColor,
          ),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),

                      LogoContainer(
                        gradienColor: const [
                          Color(0XFFB046FD),
                          Color(0XFFDF178A),
                        ],
                      ),

                      30.verticalSpace,

                      TextWidget(
                        text: 'Create Account',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                      ),

                      16.verticalSpace,

                      TextWidget(
                        text: 'Join our community and start learning together',
                        color: const Color(0XFF4A5566),
                        fontWeight: FontWeight.w600,
                        textalign: TextAlign.center,
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
                              svgImagePath:
                                  AssetsSource.authAssetsSource.authPersonIcon,
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
                            text: "Full Name",
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
                                FullnameChanged(value),
                              );
                            },
                            initialValue: state.fullname,
                            hintText: "Enter your name",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath:
                                  AssetsSource.authAssetsSource.authPersonIcon,
                              height: 18.h,
                              width: 18.w,
                            ),
                          ),
                          if (state.fullnameError != null) ...[
                            4.verticalSpace,
                            TextWidget(
                              text: state.fullnameError!,
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
                            text: "Email",
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
                              context.read<AuthBloc>().add(EmailChanged(value));
                            },
                            initialValue: state.email,
                            hintText: "Enter your email",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath:
                                  AssetsSource.authAssetsSource.mailIcon,
                              height: 16.h,
                              width: 16.w,
                            ),
                          ),
                          if (state.emailError != null) ...[
                            4.verticalSpace,
                            TextWidget(
                              text: state.emailError!,
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
                              svgImagePath:
                                  AssetsSource.authAssetsSource.lockIcon,
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
                            ? "Creating Account..."
                            : "Create Account",
                        onTap: state.status == AuthStatus.loading
                            ? () {}
                            : () {
                                context.read<AuthBloc>().add(
                                  const SignUpSubmitted(),
                                );
                              },
                        color: const [Color(0XFFB046FD), Color(0XFFDF178A)],
                        isLoading: state.status == AuthStatus.loading,
                      ),

                      32.verticalSpace,

                      TextWidget(
                        text: 'Already have an account ? Sign In',
                        color: const Color(0XFF4A5566),
                        fontSize: 16.sp,
                        highlightText: 'Sign In',
                        highlightColor: const Color(0XFF9810FA),
                        highlightFontWeight: FontWeight.w500,
                        onHighlightTap: () => getIt<NavigationService>()
                            .pushNamed(RouteName.loginScreen),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
