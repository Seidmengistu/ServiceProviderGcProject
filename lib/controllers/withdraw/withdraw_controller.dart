import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/data/repository/withdraw/withdraw_repo.dart';
import 'package:service_provider/models/withdraw/withdraw_model.dart';

import 'package:service_provider/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class WithdrawController extends GetxController {
  final WithdrawRepo withdrawRepo;
  bool _isLoad = false;
  bool get isLoad => _isLoad;

  WithdrawController({required this.withdrawRepo});
  var selectedType = 1.obs;

  var amountController = TextEditingController();

  Future<void> requestwithdraw() async {
    String token = '';
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString(AppConstants.TOKEN) ?? "None token";
    print(token);

    String amount = amountController.text.trim();
    print(amount);
    final String endPoint =
        "https://gcproject.awraticket.com/service_provider/withdraw_request";

    Dio.FormData formData = new Dio.FormData.fromMap({
      "amount": amount,
    });
    Dio.Dio dio = new Dio.Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.post(endPoint, data: formData).then((response) {
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Success",
          "Withdraw Request Send Successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.all(15),
          forwardAnimationCurve: Curves.bounceOut,
        );
      } else if (response.statusCode == 202) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Information!",
          "You have a pending request",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.all(15),
          forwardAnimationCurve: Curves.bounceIn,
        );
      }
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print(error));
  }

//to get withdraw
  List<dynamic> _withdraw = [];
  List<dynamic> get withdrawList => _withdraw;

  Future<void> getWithdrawList() async {
    Response response = await withdrawRepo.getWithdrawList();
    
    try {
      if (response.statusCode == 200) {
        _withdraw = [];
        _withdraw.addAll(Withdraw.fromJson(response.body).data);
        
        _isLoad = true;
        update();
        //like setstate
      }
    } catch (e) {
      print("e");
    }
  }
}
