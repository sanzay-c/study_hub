class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = "/api/auth/login/";
  static const String register = "/api/auth/register/";
  static const String logout = "/api/auth/logout/";
  static const String refreshToken = "/api/auth/refresh/";
  static const String deleteAccount = "/api/auth/delete_account/";

  // Auth(forgot-password)
  static const String requestReset = "/api/auth/request_reset/";
  static const String verifyOTP = "/api/auth/verify_otp/";
  static const String resetPassword = "/api/auth/reset_password/";

  // stats following, followers Groups summary
  static const String userStats = "/api/auth/me/stats/";
  static String userStatsId(String userId) => "/api/auth/users/$userId/stats/";

  // upload avatar
  static const String uploadAvatar = "/api/auth/upload_avatar/";
}
