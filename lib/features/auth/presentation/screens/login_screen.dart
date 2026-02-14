import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/logo_container.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.h), // Top spacing
                LogoContainer(
                  gradienColor: [Color(0XFF526DFF), Color(0XFF8B32FB)],
                ),
                40.verticalSpace,
                TextWidget(
                  text: 'Welcome Back',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
                16.verticalSpace,
                TextWidget(
                  text: 'Sign in to continue your learning journey',
                  textalign: TextAlign.center,
                  color: Color(0XFF4A5566),
                  fontWeight: FontWeight.w600,
                ),
                24.verticalSpace,
                Row(
                  children: [
                    TextWidget(text: "Email", fontWeight: FontWeight.w600),
                  ],
                ),
                16.verticalSpace,
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Enter your email",
                  svgIcon: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.authAssetsSource.mailIcon,
                    height: 14.74.h,
                    width: 17.61.w,
                  ),
                ),
                24.verticalSpace,
                Row(
                  children: [
                    TextWidget(text: "Password", fontWeight: FontWeight.w600),
                  ],
                ),
                16.verticalSpace,
                CustomTextFormField(
                  controller: passwordController,
                  isPassword: true,
                  hintText: "Enter your password",
                  svgIcon: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.authAssetsSource.lockIcon,
                    height: 18.36.h,
                    width: 16.73.w,
                  ),
                ),
                16.verticalSpace,
                CommonButton(
                  text: "Sign In",
                  onTap: () => getIt<NavigationService>().pushReplacementNamed(RouteName.bottomNavScreen), // only for now a demo purpose
                  color: [Color(0XFF526DFF), Color(0XFF8B32FB)],
                ),
                32.verticalSpace,
                TextWidget(
                  text: 'Don\'t have an account ? Sign Up',
                  color: Color(0XFF4A5566),
                  fontSize: 16.sp,
                  highlightText: 'Sign Up',
                  highlightColor: Color(0XFF526DFF),
                  highlightFontWeight: FontWeight.w500,
                  onHighlightTap: () => getIt<NavigationService>().pushNamed(
                    RouteName.signUpScreen,
                  ),
                ),
                40.verticalSpace, // Bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
