import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, requestSuccess, verifySuccess, resetSuccess, error }

class ForgotPasswordState extends Equatable {
  final String email;
  final String otp;
  final String newPassword;
  final ForgotPasswordStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = '',
    this.otp = '',
    this.newPassword = '',
    this.status = ForgotPasswordStatus.initial,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    String? email,
    String? otp,
    String? newPassword,
    ForgotPasswordStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, otp, newPassword, status, errorMessage];
}
