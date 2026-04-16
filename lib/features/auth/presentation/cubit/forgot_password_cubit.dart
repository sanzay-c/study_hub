import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/usecase/request_reset_usecase.dart';
import 'package:study_hub/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:study_hub/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'forgot_password_state.dart';

@lazySingleton
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestResetUseCase _requestResetUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  final emailController = TextEditingController();
  final otpControllers = List.generate(6, (index) => TextEditingController());
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ForgotPasswordCubit(
    this._requestResetUseCase,
    this._verifyOTPUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgotPasswordState());

  @override
  Future<void> close() {
    emailController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void emailChanged(String email) {
    String? error;
    if (email.isEmpty) {
      error = "Email is required";
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      error = "Invalid email format";
    }

    emit(state.copyWith(
      email: email,
      emailError: error ?? "CLEAR",
      status: ForgotPasswordStatus.initial,
    ));
  }

  void otpChanged(String otp) {
    String? error;
    if (otp.length < 6) {
      error = "Incomplete OTP";
    }

    emit(state.copyWith(
      otp: otp,
      otpError: error ?? "CLEAR",
      status: ForgotPasswordStatus.initial,
    ));
  }

  void newPasswordChanged(String password) {
    bool hasMinLength = password.length >= 8;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasNumberOrSymbol = password.contains(RegExp(r'[0-9!@#\$%^&*]'));

    double strength = 0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) strength += 0.25;

    String? error;
    if (password.isEmpty) {
      error = "Password is required";
    } else if (!hasMinLength) {
      error = "Password too short";
    }

    emit(state.copyWith(
      newPassword: password,
      passwordError: error ?? "CLEAR",
      hasMinLength: hasMinLength,
      hasUppercase: hasUppercase,
      hasNumberOrSymbol: hasNumberOrSymbol,
      strength: strength,
      status: ForgotPasswordStatus.initial,
    ));

    // Re-validate confirm password match
    _validateConfirmPassword(state.confirmPassword);
  }

  void confirmPasswordChanged(String confirmPassword) {
    _validateConfirmPassword(confirmPassword);
  }

  void _validateConfirmPassword(String confirmPassword) {
    String? error;
    if (confirmPassword.isNotEmpty && confirmPassword != state.newPassword) {
      error = "Passwords do not match";
    }

    emit(state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: error ?? "CLEAR",
      status: ForgotPasswordStatus.initial,
    ));
  }

  Future<void> requestReset() async {
    emailChanged(state.email);
    if (!state.isRequestValid) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _requestResetUseCase(state.email);
      emit(state.copyWith(status: ForgotPasswordStatus.requestSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> verifyOTP() async {
    otpChanged(state.otp);
    if (!state.isVerifyValid) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _verifyOTPUseCase(state.email, state.otp);
      emit(state.copyWith(status: ForgotPasswordStatus.verifySuccess));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> resetPassword() async {
    newPasswordChanged(state.newPassword);
    confirmPasswordChanged(state.confirmPassword);
    if (!state.isResetValid) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _resetPasswordUseCase(
        email: state.email,
        otp: state.otp,
        newPassword: state.newPassword,
      );
      emit(state.copyWith(status: ForgotPasswordStatus.resetSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
