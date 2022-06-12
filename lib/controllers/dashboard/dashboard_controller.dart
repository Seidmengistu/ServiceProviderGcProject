import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:http/http.dart' as http;
import 'package:service_provider/models/dashboard/dashboard_model.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var dashboardInformation = <DashboardModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInformation();
  }

  Future<void> fetchInformation() async {
    String token = '';

    late Map<String, String> _mainHeaders;
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";

    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            'http://www.gcproject.awraticket.com/service_provider/dashboard'),
        headers: _mainHeaders);

    if (response.statusCode == 200) {
      DashboardModel _dashboardModel =
          DashboardModel.fromJson(jsonDecode(response.body));

      dashboardInformation.add(
        DashboardModel(
          rate: _dashboardModel.rate,
          totalBooking: _dashboardModel.totalBooking,
          todayTotalBooking: _dashboardModel.todayTotalBooking,
          totalBalance: _dashboardModel.totalBalance,
        ),
      );


      isLoading.value = false;
      update();
    } else {
      print("iNdashboard");
    }
  }
}
