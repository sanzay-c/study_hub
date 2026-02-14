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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool isLoading = false;

  Future<void> _handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Your sign up logic here
      await Future.delayed(Duration(seconds: 2)); // Simulate API call
      
      // Navigate or show success
      if (mounted) {
        // Success navigation
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                SizedBox(height: 40.h),
                LogoContainer(
                  gradienColor: [Color(0XFFB046FD), Color(0XFFDF178A)],
                ),
                40.verticalSpace,
                TextWidget(
                  text: 'Create Account',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
                16.verticalSpace,
                TextWidget(
                  text: 'Join our community and start leaning together',
                  color: Color(0XFF4A5566),
                  fontWeight: FontWeight.w600,
                ),
                24.verticalSpace,
                Row(
                  children: [
                    TextWidget(text: "Full Name", fontWeight: FontWeight.w600),
                  ],
                ),
                16.verticalSpace,
                CustomTextFormField(
                  controller: fullNameController,
                  hintText: "Enter your name",
                  svgIcon: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.authAssetsSource.authPersonIcon,
                    height: 14.74.h,
                    width: 17.61.w,
                  ),
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
                  text: isLoading ? "Creating Account..." : "Create Account",
                  onTap: isLoading ? () {} : _handleSignUp,
                  color: [Color(0XFFB046FD), Color(0XFFDF178A)],
                  isLoading: isLoading, // You'll need to add this to CommonButton
                ),
                32.verticalSpace,
                TextWidget(
                  text: 'Already have an account ? Sign In',
                  color: Color(0XFF4A5566),
                  fontSize: 16.sp,
                  highlightText: 'Sign In',
                  highlightColor: Color(0XFF9810FA),
                  highlightFontWeight: FontWeight.w500,
                  onHighlightTap: () => getIt<NavigationService>().pushNamed(
                    RouteName.loginScreen,
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}