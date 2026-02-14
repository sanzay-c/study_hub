import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/logo_container.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            text: 'Sign in to continue your learning journey',
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

                          CustomTextFormField(
                            controller: emailController,
                            hintText: "Enter your username",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath:
                                  AssetsSource.authAssetsSource.authPersonIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
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

                          CustomTextFormField(
                            controller: passwordController,
                            isPassword: true,
                            hintText: "Enter your password",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath:
                                  AssetsSource.authAssetsSource.lockIcon,
                            ),
                          ),

                          24.verticalSpace,

                          CommonButton(
                            text: "Sign In",
                            onTap: () =>
                                getIt<NavigationService>().pushReplacementNamed(
                                  RouteName.bottomNavScreen,
                                ),
                            color: const [Color(0XFF526DFF), Color(0XFF8B32FB)],
                          ),

                          32.verticalSpace,

                          TextWidget(
                            text: 'Forgot Password ?',
                            color: Color(0XFF1569FC),
                          ),

                          32.verticalSpace,

                          TextWidget(
                            text: 'Don\'t have an account ? Sign Up',
                            color: const Color(0XFF4A5566),
                            fontSize: 16.sp,
                            highlightText: 'Sign Up',
                            highlightColor: const Color(0XFF1569FC),
                            highlightFontWeight: FontWeight.w500,
                            onHighlightTap: () => getIt<NavigationService>()
                                .pushReplacementNamed(RouteName.signUpScreen),
                          ),

                          40.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
