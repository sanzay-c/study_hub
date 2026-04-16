import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_state.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    40.verticalSpace,
                    TextWidget(
                      text: "OTP Verification",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    12.verticalSpace,
                    TextWidget(
                      text:
                          "We have sent a 6-digit code to your email.\nPlease check it.",
                      textalign: TextAlign.center,
                    ),
                    48.verticalSpace,
                    const OtpForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  void _onChanged(String value, int index, List<FocusNode> focusNodes) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace &&
                    cubit.otpControllers[index].text.isEmpty &&
                    index > 0) {
                  focusNodes[index - 1].requestFocus();
                }
              },
              child: SizedBox(
                height: 56.h,
                width: 45.w,
                child: TextFormField(
                  controller: cubit.otpControllers[index],
                  focusNode: focusNodes[index],
                  autofocus: index == 0,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.textColor,
                    ),
                  ),
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.5),
                      fontSize: 20.sp,
                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF757575)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: Color(0XFF526DFF),
                        width: 2.w,
                      ),
                    ),
                  ),
                  onChanged: (value) => _onChanged(value, index, focusNodes),
                ),
              ),
            );
          }),
        ),
        16.verticalSpace,
        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          buildWhen: (previous, current) => previous.otpError != current.otpError,
          builder: (context, state) {
            if (state.otpError != null) {
              return TextWidget(
                text: state.otpError!,
                color: Colors.red,
                fontSize: 12.sp,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        40.verticalSpace,
        BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.status == ForgotPasswordStatus.verifySuccess) {
              getIt<NavigationService>().pushNamed(
                RouteName.resetPasswordScreen,
              );
            } else if (state.status == ForgotPasswordStatus.error) {
              CustomToast.show(
                context,
                message: state.errorMessage ?? "Verification failed",
                type: ToastType.error,
              );
            }
          },
          builder: (context, state) {
            return CommonButton(
              text: "Verify & Continue",
              isLoading: state.status == ForgotPasswordStatus.loading,
              color: const [Color(0XFF526DFF), Color(0XFF8B32FB)],
              onTap: () {
                String otp = cubit.otpControllers.map((e) => e.text).join();
                cubit.otpChanged(otp);
                cubit.verifyOTP();
              },
            );
          },
        ),

        32.verticalSpace,
        TextWidget(text: 'Resend OTP'),
      ],
    );
  }
}
