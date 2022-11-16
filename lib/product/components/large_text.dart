import 'package:flutter/material.dart';

class CustomLargeText extends Text {
  final double? size;
  final String? text;
  final Color? color;
  final bool isCenter;

  CustomLargeText({
    this.size = 30,
    required this.text,
    this.color = Colors.white,
    Key? key,
    this.isCenter = false,
  }) : super(
          text ?? "",
          key: key,
          textAlign: isCenter ? TextAlign.center : null,
          style: TextStyle(
              fontSize: size, color: color, fontWeight: FontWeight.bold),
        );
}
