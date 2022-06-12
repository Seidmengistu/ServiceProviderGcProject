import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_provider/controllers/booking/booking_controller.dart';
import 'package:service_provider/controllers/dashboard/dashboard_controller.dart';
import 'package:service_provider/controllers/profile/profile_controller.dart';


import 'package:service_provider/controllers/review/review_controller.dart';
import 'package:service_provider/controllers/service/popular_service_controller.dart';
import 'package:service_provider/data/repository/booking/booking_repo.dart';


import 'package:service_provider/data/repository/review/review_repo.dart';

import 'package:service_provider/data/repository/service/popular_service_repo.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:service_provider/controllers/auth_controller.dart';

import 'package:service_provider/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:service_provider/data/repository/auth_repo.dart';

import 'package:service_provider/utils/app_constants.dart';

Future<void> init() async {
  EasyLoading.init();
  //for signup
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api first always load api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // in the repo we pass Api Client because it contain   "final ApiClient apiClient;""

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>PopularServiceRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ReviewRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BookingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //controller in this we pass final;
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularServiceController(popularServiceRepo: Get.find()));
  Get.lazyPut(() => ReviewController(reviewRepo: Get.find()));
  Get.lazyPut(() => BookingController(bookingRepo: Get.find()));
   Get.put(DashboardController());
    Get.put(ProfileController());
}
