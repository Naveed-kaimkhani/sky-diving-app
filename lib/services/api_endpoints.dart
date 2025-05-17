class ApiEndpoints {
  static const String baseUrl = "https://skydiverentalapp.com/api";

  static const String register = "$baseUrl/register";

  static const String login = "$baseUrl/login";
  static const String verifyOtp = "$baseUrl/otp/verify";

  static const String sendOtp = "$baseUrl/send";

  static const String referral = "$baseUrl/referral";

  static const String delete = "$baseUrl/delete-user";

  static const String userReward = "$baseUrl/user-reward";
  static const String forgetPassword = "$baseUrl/forgot-password";

  static const String updateProfile = "$baseUrl/update-profile";

  static const String validatePhone = "$baseUrl/check-phone";

  static const String changePassword = "$baseUrl/change-password";

  static const String notification = "$baseUrl/notifications";


  static const String sendMessage =
      "https://274934fb7af66daf.api-us.cometchat.io/v3/messages";
}
