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

  ForgotPasswordCubit(
    this._requestResetUseCase,
    this._verifyOTPUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgotPasswordState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: ForgotPasswordStatus.initial));
  }

  void otpChanged(String otp) {
    emit(state.copyWith(otp: otp, status: ForgotPasswordStatus.initial));
  }

  void newPasswordChanged(String password) {
    emit(state.copyWith(newPassword: password, status: ForgotPasswordStatus.initial));
  }

  Future<void> requestReset() async {
    if (state.email.isEmpty) return;

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
    if (state.email.isEmpty || state.otp.isEmpty) return;

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
    if (state.email.isEmpty || state.otp.isEmpty || state.newPassword.isEmpty) return;

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
