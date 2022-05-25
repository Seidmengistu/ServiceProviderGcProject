class AppConstants {
  static const String APP_NAME = "Serive_provider";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "http://www.gcproject.daguads.com";
  static const String TOKEN = "";
  static const String UPLOAD_URL = "/";

// For Authentication
  static const String CHECKPHONENUMBER_URI =
      "/service_provider/check_phone_number_existence";
  static const String REGISTRATION_URI = "/service_provider/register";
  static const String LOGIN_URI = "/service_provider/login";
  static const String SEND_CODE_URI = "/service_provider/resend_code";

  //For Services
  static const String POPULAR_SERVICE_URI = "/service_provider/all_services";
  //For Reviews
    static const String Review_URI = "/service_provider/reviews";
}
