import 'package:flutter/material.dart';
import 'package:service_provider/utils/dimensions.dart';


class IconAndTextWidgett extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  const IconAndTextWidgett(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: Dimensions.font16,
          ),
        ),
      ],
    );
  }
}
