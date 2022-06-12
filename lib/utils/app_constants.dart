class AppConstants {
  static const String APP_NAME = "Serive_provider";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "http://www.gcproject.awraticket.com";
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

    //for tODAY bookings
    static const String TODAY_ALL_BOOKING_URI = "/service_provider/today_all_bookings";
    static const String TODAY_TO_BE_DONE_BOOKING_URI = "/service_provider/today_to_be_done_bookings";
    static const String TODAY_COMPLETED_BOOKING_URI = "/service_provider/today_completed_bookings";
    //For General Booking
    static const String GENERAL_ALL_BOOKING_URI = "/service_provider/all_bookings";
    static const String GENERAL_TO_BE_DONE_BOOKING_URI = "/service_provider/to_be_done_bookings";
    static const String GENERAL_COMPLETED_BOOKING_URI = "/service_provider/completed_bookings";
    //For profile Info
    static const String PROFILE_INFO="/service_provider/profile";

    //Payment
    static const String GET_PAYMENT_METHOD_URI="/service_provider/get_payment_method";

}
