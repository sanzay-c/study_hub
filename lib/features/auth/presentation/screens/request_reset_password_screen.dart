import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:study_hub/features/auth/presentation/cubit/forgot_password_state.dart';

class RequestResetPasswordScreen extends StatelessWidget {
  const RequestResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      body: Center(
        // Content lai horizontally center garcha
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically center garcha
            crossAxisAlignment:
                CrossAxisAlignment.center, // Items lai center ma align garcha
            children: [
              // ── Header Icon ──
              Container(
                padding: EdgeInsets.all(22.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0XFF526DFF), Color(0XFF8B32FB)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF526DFF).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mail_lock_rounded,
                  size: 50.sp,
                  color: Colors.white,
                ),
              ),
              32.verticalSpace,

              // ── Title & Subtitle ──
              TextWidget(
                text: "Reset Password",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                textalign: TextAlign.center,
              ),
              12.verticalSpace,
              TextWidget(
                text:
                    "Enter the email address you used while creating your account, and we will send you a reset OTP.",
                fontSize: 15.sp,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
                textalign: TextAlign.center,
              ),
              40.verticalSpace,

              // ── Form Area ──
              const ForgotPassForm(),

              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Labels left mai baseko ramro dekhincha
        children: [
          TextWidget(
            text: "Email Address",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          8.verticalSpace,
          CustomTextFormField(
            controller: _emailController,
            hintText: "example@gmail.com",
            onChanged: (value) => context.read<ForgotPasswordCubit>().emailChanged(value),
            svgIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: const Color(0XFF4A5566),
            ),
          ),
          32.verticalSpace,

          BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.status == ForgotPasswordStatus.requestSuccess) {
                getIt<NavigationService>().pushNamed(RouteName.verifyOTPScreen);
              } else if (state.status == ForgotPasswordStatus.error) {
                CustomToast.show(
                  context,
                  message: state.errorMessage ?? "Something went wrong",
                  type: ToastType.error,
                );
              }
            },
            builder: (context, state) {
              return CommonButton(
                text: "Send Request",
                isLoading: state.status == ForgotPasswordStatus.loading,
                color: const [Color(0XFF526DFF), Color(0XFF8B32FB)],
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ForgotPasswordCubit>().requestReset();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
