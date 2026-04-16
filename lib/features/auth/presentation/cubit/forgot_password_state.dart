import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, requestSuccess, verifySuccess, resetSuccess, error }

class ForgotPasswordState extends Equatable {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword;
  final ForgotPasswordStatus status;
  
  // Validation errors
  final String? emailError;
  final String? otpError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  // Password strength indicators
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasNumberOrSymbol;
  final double strength; // 0.0 to 1.0

  const ForgotPasswordState({
    this.email = '',
    this.otp = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.status = ForgotPasswordStatus.initial,
    this.emailError,
    this.otpError,
    this.passwordError,
    this.confirmPasswordError,
    this.errorMessage,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasNumberOrSymbol = false,
    this.strength = 0,
  });

  bool get passwordsMatch => newPassword.isNotEmpty && newPassword == confirmPassword;
  bool get isRequestValid => email.isNotEmpty && emailError == null;
  bool get isVerifyValid => otp.length == 6 && otpError == null;
  bool get isResetValid => isPasswordStrong && passwordsMatch;
  bool get isPasswordStrong => hasMinLength && hasUppercase && hasNumberOrSymbol;

  ForgotPasswordState copyWith({
    String? email,
    String? otp,
    String? newPassword,
    String? confirmPassword,
    ForgotPasswordStatus? status,
    String? emailError,
    String? otpError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasNumberOrSymbol,
    double? strength,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      emailError: emailError == "CLEAR" ? null : (emailError ?? this.emailError),
      otpError: otpError == "CLEAR" ? null : (otpError ?? this.otpError),
      passwordError: passwordError == "CLEAR" ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: confirmPasswordError == "CLEAR" ? null : (confirmPasswordError ?? this.confirmPasswordError),
      errorMessage: errorMessage ?? this.errorMessage,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasNumberOrSymbol: hasNumberOrSymbol ?? this.hasNumberOrSymbol,
      strength: strength ?? this.strength,
    );
  }

  @override
  List<Object?> get props => [
        email,
        otp,
        newPassword,
        confirmPassword,
        status,
        emailError,
        otpError,
        passwordError,
        confirmPasswordError,
        errorMessage,
        hasMinLength,
        hasUppercase,
        hasNumberOrSymbol,
        strength,
      ];
}
