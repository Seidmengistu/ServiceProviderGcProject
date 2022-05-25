import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/pages/auth/signup.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_text_field.dart';
import 'package:service_provider/widgets/big_text.dart';
import 'package:service_provider/widgets/header_widget.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  var passwordController = TextEditingController();

  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(children: [
          Container(
            height: 150,
            child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
          ),
          Container(
            padding: EdgeInsets.only(top: Dimensions.height30 * 3),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login to your account",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 100),
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/background.png"),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        AppTextField(
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            textController: phoneController),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          hintText: "Password",
                          icon: Icons.password,
                          textController: passwordController,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: Colors.blue[500],
                        ),
                        child: Center(
                          child: BigText(
                            text: 'Login',
                            size: Dimensions.font26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignupPage());
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
