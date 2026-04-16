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
    return Scaffold(
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
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      _controllers[index].text.isEmpty &&
                      index > 0) {
                    _focusNodes[index - 1].requestFocus();
                  }
                },
                child: SizedBox(
                  height: 56.h,
                  width: 45.w,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
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
                        color: Colors.grey.withOpacity(0.5),
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
                    onChanged: (value) => _onChanged(value, index),
                  ),
                ),
              );
            }),
          ),
          24.verticalSpace,
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
                  String otp = _controllers.map((e) => e.text).join();
                  if (otp.length < 6) {
                    CustomToast.show(
                      context,
                      message: "Please enter full 6-digit code",
                      type: ToastType.info,
                    );
                  } else {
                    context.read<ForgotPasswordCubit>().otpChanged(otp);
                    context.read<ForgotPasswordCubit>().verifyOTP();
                  }
                },
              );
            },
          ),

          32.verticalSpace,
          TextWidget(text: 'Resend OTP'),
        ],
      ),
    );
  }
}
