import 'package:flutter/material.dart';
import 'package:service_provider/utils/dimensions.dart';
import 'package:service_provider/widgets/app_icon.dart';
import 'package:service_provider/widgets/big_text.dart';

// ignore: must_be_immutable
class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigText
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 2,
          offset: Offset(0, 6),
          color: Colors.grey.withOpacity(0.2),
        )
      ]),
    );
  }
}
