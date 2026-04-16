import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  double _strength = 0;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    // Listening to changes to update the UI indicators in real-time
    _passwordController.addListener(_evaluatePassword);
    _confirmPasswordController.addListener(_checkMatch);
  }

  void _evaluatePassword() {
    final p = _passwordController.text;
    double s = 0;
    if (p.length >= 8) s += 0.25;
    if (p.contains(RegExp(r'[A-Z]'))) s += 0.25;
    if (p.contains(RegExp(r'[0-9]'))) s += 0.25;
    if (p.contains(RegExp(r'[!@#\$%^&*]'))) s += 0.25;
    
    if (mounted) {
      setState(() => _strength = s);
      _checkMatch();
    }
  }

  void _checkMatch() {
    if (mounted) {
      setState(() {
        _passwordsMatch = _passwordController.text.isNotEmpty &&
            _passwordController.text == _confirmPasswordController.text;
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subTextColor = getColorByTheme(
      context: context,
      colorClass: AppColors.subTextColor,
    );

    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      // appBar: const StudyHubAppBar(title: ""),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Center(child: _buildIconHeader(context)),
                32.verticalSpace,
                TextWidget(
                  text: "Create new password",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                8.verticalSpace,
                TextWidget(
                  text: "Must be different from your previous password.",
                  color: subTextColor,
                  fontSize: 14.sp,
                ),
                32.verticalSpace,

                // ── New Password ──
                _buildLabel("New password"),
                8.verticalSpace,
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "Min. 8 characters",
                  isPassword: true,
                  svgIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF4A5566)),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) return "Please enter a password";
                  //   if (value.length < 8) return "Password too short";
                  //   return null;
                  // },
                ),
                12.verticalSpace,
                _buildStrengthBar(context),

                24.verticalSpace,

                // ── Confirm Password ──
                _buildLabel("Confirm password"),
                8.verticalSpace,
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: "Re-enter new password",
                  isPassword: true,
                  svgIcon: const Icon(Icons.lock_reset_rounded, color: Color(0xFF4A5566)),
                  // validator: (value) {
                  //   if (value != _passwordController.text) return "Passwords do not match";
                  //   return null;
                  // },
                ),
                if (_confirmPasswordController.text.isNotEmpty) ...[
                  8.verticalSpace,
                  _buildMatchIndicator(),
                ],

                24.verticalSpace,
                _buildRequirementsBox(context),

                32.verticalSpace,

                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state.status == ForgotPasswordStatus.resetSuccess) {
                      CustomToast.show(
                        context,
                        message: "Password updated successfully!",
                        type: ToastType.success,
                      );
                      // Clear the cubit state for future use since it's a singleton
                      // context.read<ForgotPasswordCubit>().reset(); // If needed
                      
                      getIt<NavigationService>().pushNamedAndRemoveUntil(
                          RouteName.loginScreen, (route) => false);
                    } else if (state.status == ForgotPasswordStatus.error) {
                      CustomToast.show(
                        context,
                        message: state.errorMessage ?? "Failed to update password",
                        type: ToastType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CommonButton(
                      text: "Update password",
                      isLoading: state.status == ForgotPasswordStatus.loading,
                      color: const [Color(0xFF526DFF), Color(0xFF8B32FB)],
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (!_passwordsMatch) {
                            CustomToast.show(context, message: "Passwords do not match", type: ToastType.error);
                            return;
                          }
                          context.read<ForgotPasswordCubit>().newPasswordChanged(_passwordController.text);
                          context.read<ForgotPasswordCubit>().resetPassword();
                        }
                      },
                    );
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

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return TextWidget(text: text, fontWeight: FontWeight.w600, fontSize: 14.sp);
  }

  Widget _buildIconHeader(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF526DFF), Color(0xFF8B32FB)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF526DFF).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Icon(Icons.shield_moon_outlined, size: 32.sp, color: Colors.white),
    );
  }

  Widget _buildStrengthBar(BuildContext context) {
    final Color color;
    final String label;
    if (_strength <= 0.25) {
      color = const Color(0xFFE24B4A);
      label = 'Weak';
    } else if (_strength <= 0.5) {
      color = const Color(0xFFEF9F27);
      label = 'Fair';
    } else if (_strength <= 0.75) {
      color = Colors.blueAccent;
      label = 'Good';
    } else {
      color = const Color(0xFF1D9E75);
      label = 'Strong';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) {
            bool isFilled = i < (_strength * 4).round();
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4.h,
                margin: EdgeInsets.only(right: i < 3 ? 6.w : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: isFilled ? color : Colors.grey.withOpacity(0.2),
                ),
              ),
            );
          }),
        ),
        if (_passwordController.text.isNotEmpty) ...[
          6.verticalSpace,
          TextWidget(text: "Strength: $label", fontSize: 12.sp, color: color, fontWeight: FontWeight.bold),
        ],
      ],
    );
  }

  Widget _buildMatchIndicator() {
    final color = _passwordsMatch ? const Color(0xFF1D9E75) : const Color(0xFFE24B4A);
    return Row(
      children: [
        Icon(_passwordsMatch ? Icons.check_circle_outline : Icons.error_outline, size: 14.sp, color: color),
        6.horizontalSpace,
        TextWidget(
          text: _passwordsMatch ? 'Passwords match' : 'Passwords do not match',
          fontSize: 12.sp,
          color: color,
        ),
      ],
    );
  }

  Widget _buildRequirementsBox(BuildContext context) {
    final p = _passwordController.text;
    final reqs = [
      (label: 'At least 8 characters', met: p.length >= 8),
      (label: 'One uppercase letter', met: p.contains(RegExp(r'[A-Z]'))),
      (label: 'One number or symbol', met: p.contains(RegExp(r'[0-9!@#\$%^&*]'))),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: 'Password requirements', fontSize: 13.sp, fontWeight: FontWeight.bold),
          12.verticalSpace,
          ...reqs.map((r) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Icon(
                  r.met ? Icons.check_circle : Icons.circle_outlined,
                  size: 16.sp,
                  color: r.met ? const Color(0xFF1D9E75) : Colors.grey,
                ),
                10.horizontalSpace,
                TextWidget(text: r.label, fontSize: 13.sp, color: r.met ? null : Colors.grey),
              ],
            ),
          )),
        ],
      ),
    );
  }

}