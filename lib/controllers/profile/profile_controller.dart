import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import 'package:service_provider/models/profile/profile_model.dart';
import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var profileInfo = <Profile>[].obs;
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
        Uri.parse(AppConstants.BASE_URL + AppConstants.PROFILE_INFO),
        headers: _mainHeaders);

    if (response.statusCode == 200) {
   
      Profile _profileInfo = Profile.fromJson(jsonDecode(response.body));

      profileInfo.add(
        Profile(
            businessName: _profileInfo.businessName,
            phoneNumber: _profileInfo.phoneNumber,
            ownerName: _profileInfo.ownerName,
            latitude: _profileInfo.latitude,
            longitude: _profileInfo.longitude,
            logo: _profileInfo.logo,
            type: _profileInfo.type,
            createdAt: _profileInfo.createdAt,
            updatedAt: _profileInfo.updatedAt),
      );
      
      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }
}
