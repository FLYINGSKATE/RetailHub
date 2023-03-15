class API {
  static String domain = 'dev1.retailhub.ai';
  static String baseURL = "https://$domain/";
  static String apiURL = "https://$domain/api/registration/v1";

  static String login = "$apiURL/mobile/login";
  static String register = "$apiURL/registration/retailer/register";
  static String forgetpassword = "$apiURL/password-recovery";
  static String changePassword = "$apiURL/settings/user/change-password";
  static String updateAccount =
      "$apiURL/settings/retailer/update-account-information";
  static String searchAll = "$apiURL/browse/all";
  static String blogs = "$apiURL/blogs";

  static String articles = "${baseURL}api/v1/startup/article";
  static String events = "${baseURL}api/events";
  static String training = "${baseURL}api/training";
  static String coworking = "https://api.jsonbin.io/v3/b/63de01c1c0e7653a056ee485";
}
