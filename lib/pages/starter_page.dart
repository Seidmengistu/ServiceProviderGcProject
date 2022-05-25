import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/pages/auth/otp_register.dart';
class StarterPage extends StatelessWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Service Provider",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/l2.png"))),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Get.to(() => Register());
                    },
                    color: Color(0xff0095FF),
                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Get Started",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  // creating the signup button
                  SizedBox(height: 20),
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 60,
                  //   onPressed: () {
                  //     Get.to(() => SignupPage());
                  //   },
                  //   color: Color(0xff0095FF),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(50)),
                  //   child: Text(
                  //     "Sign up",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 18),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
