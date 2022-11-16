import 'package:dalle_flutter_mobile_app/core/init/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'i_ligth_theme.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance => _instance ??= AppThemeLight._init();
  AppThemeLight._init();

  @override
  ThemeData? get theme => ThemeData.light().copyWith(
        colorScheme: _colorScheme,
        primaryColor: _colorScheme.primary,
        progressIndicatorTheme: _progress,
      );

  ProgressIndicatorThemeData get _progress => ProgressIndicatorThemeData(
        color: _colorScheme.primary,
      );

  ColorScheme get _colorScheme => ThemeData.light().colorScheme.copyWith(
        background: colorsScheme?.backgroundColor,
        primary: colorsScheme?.primaryColor,
        secondary: colorsScheme?.vividCerulean,
      );
}
