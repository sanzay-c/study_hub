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
    setState(() => isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        getIt<NavigationService>()
            .pushReplacementNamed(RouteName.bottomNavScreen);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        resizeToAvoidBottomInset: true,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            text:
                                'Join our community and start learning together',
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
      
                          16.verticalSpace,
      
                          CustomTextFormField(
                            controller: fullNameController,
                            hintText: "Enter your username",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath: AssetsSource
                                  .authAssetsSource.authPersonIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
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
      
                          CustomTextFormField(
                            controller: fullNameController,
                            hintText: "Enter your name",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath: AssetsSource
                                  .authAssetsSource.authPersonIcon,
                             height: 20.h,
                              width: 20.w,
                            ),
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
      
                          CustomTextFormField(
                            controller: emailController,
                            hintText: "Enter your email",
                            svgIcon: SvgImageRenderWidget(
                              svgImagePath:
                                  AssetsSource.authAssetsSource.mailIcon,
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
                            text: isLoading
                                ? "Creating Account..."
                                : "Create Account",
                            onTap: isLoading ? () {} : _handleSignUp,
                            color: const [
                              Color(0XFFB046FD),
                              Color(0XFFDF178A),
                            ],
                            isLoading: isLoading,
                          ),
      
                          32.verticalSpace,
      
                          TextWidget(
                            text: 'Already have an account ? Sign In',
                            color: const Color(0XFF4A5566),
                            fontSize: 16.sp,
                            highlightText: 'Sign In',
                            highlightColor: const Color(0XFF9810FA),
                            highlightFontWeight: FontWeight.w500,
                            onHighlightTap: () =>
                                getIt<NavigationService>()
                                    .pushNamed(RouteName.loginScreen),
                          ),
      
                          // 40.verticalSpace,
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