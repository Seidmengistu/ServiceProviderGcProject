import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/data/repository/auth_repo.dart';
import 'package:service_provider/models/auth/check_phone_body.dart';
import 'package:service_provider/models/auth/check_phone_response_model.dart';
import 'package:service_provider/models/auth/login_model.dart';
import 'package:service_provider/models/auth/response_model.dart';
import 'package:service_provider/models/auth/send_code_body.dart';
import 'package:service_provider/models/auth/send_response_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  var isLogoPathSet = false.obs;
  var logoPath = "".obs;

//for image pick
  void setPath(String path) {
    logoPath.value = path;
    isLogoPathSet.value = true;
  }

  AuthController({required this.authRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoadedd = false;
  bool get isLoadedd => _isLoadedd;

//check Phone Number Existence

//create method

  Future<CheckPhoneResponseModel> otpCheckPhone(
      CheckPhoneNumberBody checkPhoneNumberBody) async {
    update();

    Response response = await authRepo.otpCheckPhone(checkPhoneNumberBody);
    late CheckPhoneResponseModel checkPhoneResponseModel;
print(response.body);
    if (response.statusCode == 200) {
      print("correct");
      checkPhoneResponseModel =
          CheckPhoneResponseModel(response.body['is_exist']);
    } else if (response.statusCode == 422) {
      EasyLoading.dismiss();

      showCustomSnackBar(response.body["phone_number"].toString());
    } else {
      EasyLoading.dismiss();
      showCustomSnackBar("Server Error");
    }
    // _isLoaded = true;
    update();
    return checkPhoneResponseModel;
  }

//For Login
  Future<ResponseModel> login(LoginModelBody loginModelBody) async {
  
    _isLoadedd = true;
    update();
    Response response = await authRepo.login(loginModelBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      
      responseModel =
          ResponseModel(response.body['status'], response.body['token']);
          print(response.body['token']);
    } else {
      EasyLoading.dismiss();
      showCustomSnackBar(response.body.toString());
    }
    _isLoadedd = true;
    update();
    return responseModel;
  }

//sendcode
  Future<SendResponseModel> sendCode(SendCodeBody sendCodeBody) async {
    _isLoaded = true;
    Response response = await authRepo.sendCode(sendCodeBody);
    print(response.body["status"]);
    late SendResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = SendResponseModel(response.body['status']);
    } else {
      EasyLoading.dismiss();
      showCustomSnackBar(response.body['message']);
    }
    _isLoaded = false;
    update();
    return responseModel;
  }

//    bool userLoggedIn()  {
//   return  authRepo.userLoggedIn();
// }
}
