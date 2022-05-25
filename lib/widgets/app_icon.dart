import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final icon;
  final Color backgroundColor;
  // ignore: non_constant_identifier_names
  final Color IconColor;
  final double size;
  final double iconSize;

  AppIcon(
      {Key? key,
      required this.icon, //b/c only icon is required
      this.backgroundColor = const Color(0xFFfcf4e4),
      // ignore: non_constant_identifier_names
      this.IconColor = const Color(0xFF756d54),
      this.size = 40,
      this.iconSize=16,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: IconColor,
        size: iconSize
      ),
    );
  }
}
