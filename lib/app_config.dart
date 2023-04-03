class AppConfig {
  AppConfig._();
  factory AppConfig() => AppConfig._();

  static const String appName = "JacobPro";
  static const bool https = false;

  //configure this
  static const domainPath = "api.jacobpro.net"; //localhost

  static const String apiEndPoint = "/api";
  //do not configure these below
  static const String protocol = https ? "https://" : "http://";

  static String baseUrl = protocol + domainPath + apiEndPoint;

  static const String developerCompanyUrl = "https://abirahsan.com";
  static const String imageBaseUrl = "http://jacobpro.api.jacobpro.net/Files/";
}
