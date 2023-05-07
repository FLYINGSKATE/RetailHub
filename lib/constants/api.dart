class API {
  static String domain = 'dev1.retailhub.ai';
  static String baseURL = "https://$domain/";
  static String apiURL = "https://$domain/api";

  static String login = "$apiURL/login";
  static String register = "$apiURL/register";
  static String forgetpassword = "$apiURL/forgetPassword";
  static String changePassword = "$apiURL/password/update";
  static String updateAccount =
      "$apiURL/update/profile";

//Articles
  static String articles = "$apiURL/articles";
  static String articlesbyTag = "$apiURL/articles/tags/";
}
