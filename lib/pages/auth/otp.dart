import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/base/show_custom_snackbar.dart';
import 'package:service_provider/controllers/auth_controller.dart';
import 'package:service_provider/models/auth/login_model.dart';
import 'package:service_provider/pages/services/home_page.dart';
import 'package:service_provider/utils/dimensions.dart';

class Otp extends StatefulWidget {
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();

    void _login() {
      var authController = Get.find<AuthController>();

      String code = codeController.text.trim();
      var phone = Get.arguments;
      String device = "Android";

      print(phone);

      LoginModelBody loginModelBody =
          LoginModelBody(phone: phone, code: code, device: device);
      authController.login(loginModelBody).then((responseModel) {
        if (responseModel.isSuccess == "success") {
          Get.to(() => SHomePage(selectedIndex: 1,));
        } else {
          EasyLoading.dismiss();
          print("error");
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
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: Dimensions.font16 * 2,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height15 + 3,
                ),
                Container(
                  width: Dimensions.width50 * 4,
                  height: Dimensions.height50 * 4,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: AssetImage("assets/l2.png"),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 + 14,
                ),
                Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: Dimensions.font26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.code,
                              color: Colors.blue,
                            ),
                            labelText: "Enter Your OTP code",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.blue,
                              ),
                            ),

                            //enabled boredr
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                )),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ))),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (codeController.text.isEmpty) {
                            showCustomSnackBar('Type in your otp code ',
                                title: 'Otp');
                          } else if (codeController.text.length < 6) {
                            showCustomSnackBar('Your otp code must be 6 Digit',
                                title: 'Otp');
                          } else {
                            EasyLoading.show(status: "Verifying...");
                            _login();
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Text(
                  "Didn't you receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
