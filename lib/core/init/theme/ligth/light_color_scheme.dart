import 'package:flutter/material.dart';

class LightColorsScheme {
  static LightColorsScheme? _instance;
  static LightColorsScheme? get instance =>
      _instance ??= LightColorsScheme._init();
  LightColorsScheme._init();
  final Color backgroundColor = Colors.grey.shade500.withOpacity(.2);
  final Color primaryColor = const Color(0xFF5d69b3);
  final Color vividCerulean = const Color(0xff05a9ea);
}
