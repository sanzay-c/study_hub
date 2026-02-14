class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = "/auth/login/";
  static const String register = "/api/auth/register/";
  static const String logout = "/api/auth/logout/";
  static const String refreshToken = "/api/auth/refresh/";
  static const String deleteAccount = "/api/auth/delete_account/";

  // Auth(forgot-password)
  static const String requestReset = "/api/auth/request_reset/";
  static const String verifyOTP = "/api/auth/verify_otp/";
  static const String resetPassword = "/api/auth/reset_password/";
} 
