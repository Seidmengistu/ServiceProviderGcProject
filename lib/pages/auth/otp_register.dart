import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/base/custom_loader.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/auth_controller.dart';
import 'package:service_provider/models/auth/check_phone_body.dart';
import 'package:service_provider/models/auth/login_model.dart';
import 'package:service_provider/models/auth/send_code_body.dart';
import 'package:service_provider/pages/auth/login.dart';
import 'package:service_provider/pages/auth/otp.dart';
import 'package:service_provider/pages/auth/signup.dart';
import 'package:service_provider/pages/dashboard.dart';
import 'package:service_provider/pages/starter_page.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/big_text.dart';

class Register extends StatefulWidget {
  // const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Otp otp = new Otp();
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      // print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    var phoneController = TextEditingController();

    void _checkPhoneExistence() {
      var authController = Get.find<AuthController>();

      String phone = phoneController.text.trim();

      CheckPhoneNumberBody checkPhoneNumberBody =
          CheckPhoneNumberBody(phone: phone);

      authController.otpCheckPhone(checkPhoneNumberBody).then((status) {
        if (status.isExist!) {
          SendCodeBody sendCodeBody = SendCodeBody(phone: phone);
          authController.sendCode(sendCodeBody).then((responseModel) {
            if (responseModel.isSuccess == "success") {
              EasyLoading.dismiss();
              Get.to(() => Otp(), arguments: phone);
            } else {
              EasyLoading.dismiss();
              showCustomSnackBar("Some thing wrong please tray again");
            }
          });
        } else {
          EasyLoading.dismiss();
          Get.to(() => SignupPage(), arguments: phone);
        }
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => StarterPage());
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: Dimensions.font16 * 2,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: Dimensions.height50 * 4,
                  height: Dimensions.width50 * 4,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: AssetImage("assets/l2.png"),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        style: TextStyle(
                          fontSize: Dimensions.font16 + 2,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '(+251)',
                              style: TextStyle(
                                fontSize: Dimensions.font16 + 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: Dimensions.font16 * 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (phoneController.text.isEmpty) {
                            showCustomSnackBar('Type in your phone number',
                                title: 'phone');
                          } else if (phoneController.text.length < 10) {
                            showCustomSnackBar(
                                'Your phone number must be 10 Digits',
                                title: 'phone');
                          } else {
                            EasyLoading.show(status: 'Checking...');
                            _checkPhoneExistence();
                          }
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: Colors.blue[700],
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Send',
                              size: Dimensions.font26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
