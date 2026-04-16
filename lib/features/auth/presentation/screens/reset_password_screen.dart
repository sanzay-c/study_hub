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

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final subTextColor = getColorByTheme(
      context: context,
      colorClass: AppColors.subTextColor,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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

                _buildLabel("New password"),

                8.verticalSpace,
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.passwordError != current.passwordError,
                  builder: (context, state) {
                    return CustomTextFormField(
                      controller: cubit.passwordController,
                      hintText: "Min. 8 characters",
                      isPassword: true,
                      errorText: state.passwordError,
                      onChanged: (value) => cubit.newPasswordChanged(value),
                      svgIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xFF4A5566),
                      ),
                    );
                  },
                ),
                12.verticalSpace,
                _buildStrengthBar(context),

                24.verticalSpace,

                _buildLabel("Confirm password"),
                8.verticalSpace,
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.confirmPasswordError !=
                      current.confirmPasswordError,
                  builder: (context, state) {
                    return CustomTextFormField(
                      controller: cubit.confirmPasswordController,
                      hintText: "Re-enter new password",
                      isPassword: true,
                      errorText: state.confirmPasswordError,
                      onChanged: (value) => cubit.confirmPasswordChanged(value),
                      svgIcon: const Icon(
                        Icons.lock_reset_rounded,
                        color: Color(0xFF4A5566),
                      ),
                    );
                  },
                ),
                _buildMatchIndicator(),

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
                      getIt<NavigationService>().pushNamedAndRemoveUntil(
                        RouteName.loginScreen,
                        (route) => false,
                      );
                    } else if (state.status == ForgotPasswordStatus.error) {
                      CustomToast.show(
                        context,
                        message:
                            state.errorMessage ?? "Failed to update password",
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
                        cubit.resetPassword();
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
          ),
        ],
      ),
      child: Icon(Icons.shield_moon_outlined, size: 32.sp, color: Colors.white),
    );
  }

  Widget _buildStrengthBar(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.strength != current.strength ||
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        final Color color;
        final String label;
        if (state.strength <= 0.25) {
          color = const Color(0xFFE24B4A);
          label = 'Weak';
        } else if (state.strength <= 0.5) {
          color = const Color(0xFFEF9F27);
          label = 'Fair';
        } else if (state.strength <= 0.75) {
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
                bool isFilled = i < (state.strength * 4).round();
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
            if (state.newPassword.isNotEmpty) ...[
              6.verticalSpace,
              TextWidget(
                text: "Strength: $label",
                fontSize: 12.sp,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildMatchIndicator() {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.passwordsMatch != current.passwordsMatch ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        if (state.confirmPassword.isEmpty) return const SizedBox.shrink();

        final match = state.passwordsMatch;
        final color = match ? const Color(0xFF1D9E75) : const Color(0xFFE24B4A);
        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            children: [
              Icon(
                match ? Icons.check_circle_outline : Icons.error_outline,
                size: 14.sp,
                color: color,
              ),
              6.horizontalSpace,
              TextWidget(
                text: match ? 'Passwords match' : 'Passwords do not match',
                fontSize: 12.sp,
                color: color,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRequirementsBox(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.hasMinLength != current.hasMinLength ||
          previous.hasUppercase != current.hasUppercase ||
          previous.hasNumberOrSymbol != current.hasNumberOrSymbol,
      builder: (context, state) {
        final reqs = [
          (label: 'At least 8 characters', met: state.hasMinLength),
          (label: 'One uppercase letter', met: state.hasUppercase),
          (label: 'One number or symbol', met: state.hasNumberOrSymbol),
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
              TextWidget(
                text: 'Password requirements',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
              12.verticalSpace,
              ...reqs.map(
                (r) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        r.met ? Icons.check_circle : Icons.circle_outlined,
                        size: 16.sp,
                        color: r.met ? const Color(0xFF1D9E75) : Colors.grey,
                      ),
                      10.horizontalSpace,
                      TextWidget(
                        text: r.label,
                        fontSize: 13.sp,
                        color: r.met ? null : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
