import 'package:get/get_connect/http/src/response/response.dart';
import 'package:service_provider/data/api/api_client.dart';
import 'package:service_provider/models/auth/check_phone_body.dart';
import 'package:service_provider/models/auth/login_model.dart';
import 'package:service_provider/models/auth/send_code_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:service_provider/utils/app_constants.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences; //to save token

  AuthRepo({required this.apiClient, required this.sharedPreferences});

//call a amethod similar to controller

  Future<Response<dynamic>> otpCheckPhone(CheckPhoneNumberBody checkPhoneNumberBody) async {
    return await apiClient.postDataCheckPhone(AppConstants.CHECKPHONENUMBER_URI, checkPhoneNumberBody.toJson());

        //fOR lOGIN
  }
 Future<Response<dynamic>> login(LoginModelBody loginModelBody) async{
    return await apiClient.postData(AppConstants.LOGIN_URI, loginModelBody.toJson());
  }

  
  Future<Response<dynamic>> sendCode(SendCodeBody sendCodeBody) async{
    return await apiClient.postData(AppConstants.SEND_CODE_URI, sendCodeBody.toJson());
  }

  bool userLoggedIn()  {
  return  sharedPreferences.containsKey(AppConstants.TOKEN);
}
 getUserToken(){
  return sharedPreferences.getString(AppConstants.TOKEN)??"None Token";
}
  //save token from
  Future<bool>saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
}
