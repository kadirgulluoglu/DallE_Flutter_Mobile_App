import 'package:flutter/material.dart';

class CustomText extends Text {
  final double? size;
  final String text;
  final Color? color;
  final bool isCenter;

  CustomText({
    this.size,
    required this.text,
    this.color = Colors.white,
    Key? key,
    this.isCenter = false,
  }) : super(
          text,
          key: key,
          textAlign: isCenter ? TextAlign.center : null,
          style: TextStyle(color: color, fontSize: size),
        );
}
