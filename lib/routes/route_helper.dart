import 'package:get/get.dart';
import 'package:service_provider/pages/booking/booking_detail.dart';
import 'package:service_provider/pages/services/main_service_page.dart';

import 'package:service_provider/pages/services/popular_service_detail.dart';
import 'package:service_provider/pages/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splashscreen";
  static const String intial = "/";
  static const String popularService = "/popular-service";
  static const String bookingService = "/booking-service";
  static const String mainServicePage = "/mainservicepage";

  // static const String recomendedFood = "/recomended-food";

  static String getSplashScreen() => '$splashScreen';
  static String getMainServicePage() => '$mainServicePage';
  static String getIntial() => '$intial'; // for parameterd route like send id
  static String getPopularService(int pageId) =>
      '$popularService?pageId=$pageId';
  static String getBookingList(int pageId) => '$bookingService?pageId=$pageId';
  // static String getRecomendedFood(int pageId) =>'$recomendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
        name: mainServicePage,
        page: () {
          return MainServiceList();
        }),
    //for popular food
    GetPage(
        name: popularService,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularServiceDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    // //for Booking List
    GetPage(
        name: bookingService,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularServiceDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
