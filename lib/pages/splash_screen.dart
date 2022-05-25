import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/pages/starter_page.dart';
import 'package:service_provider/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 5), () => Get.to(()=>StarterPage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image(
                image: AssetImage("assets/l2.png"),
                width: Dimensions.splashimg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
