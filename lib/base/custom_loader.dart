import 'package:flutter/material.dart';
import 'package:service_provider/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("i am loading " + Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
