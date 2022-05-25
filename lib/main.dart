import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:service_provider/controllers/auth_controller.dart';
import 'package:service_provider/controllers/dashboard/dashboard_controller.dart';
import 'package:service_provider/controllers/review/review_controller.dart';
import 'package:service_provider/pages/auth/otp.dart';
import 'package:service_provider/pages/splash_screen.dart';
import 'controllers/service/popular_service_controller.dart';

import 'helper/dependencies.dart' as dep;
import 'routes/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();

  runApp(HomePage());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularServiceController>().getPopularServiceList();
    Get.find<ReviewController>().getReviewList();
    Get.put<DashboardController>(DashboardController()).fetchInformation();
    // return GetBuilder<AuthController>(builder: (_) {
    return GetBuilder<PopularServiceController>(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Service_Provider',
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: RouteHelper.getSplashScreen(),
        getPages: RouteHelper.routes,
        builder: EasyLoading.init(),
      );
      // });
      // });
    });
  }
}
