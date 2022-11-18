import 'dart:ui';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get shortestSide => mediaQuery.size.shortestSide;
  Orientation get orientation => mediaQuery.orientation;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get value3 => height * 0.03;
  double get mediumValue => height * 0.05;
  double get highValue => height * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
  EdgeInsets get paddingButton => const EdgeInsets.all(20.0);
}

extension PaddingExtensionOnly on BuildContext {
  EdgeInsets get paddingLowTop => EdgeInsets.only(top: lowValue);
  EdgeInsets get paddingNormalTop => EdgeInsets.only(top: normalValue);
  EdgeInsets get paddingMediumTop => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingProfile => const EdgeInsets.only(top: 60, left: 20);
  EdgeInsets get paddingRight => const EdgeInsets.only(right: 20);
  EdgeInsets get paddingCard => const EdgeInsets.only(right: 15, top: 15);
  EdgeInsets get paddingFavorite =>
      const EdgeInsets.only(right: 15, top: 10, left: 15);
  EdgeInsets get paddingLeft => const EdgeInsets.only(left: 20);
  EdgeInsets get paddingHomePage =>
      const EdgeInsets.only(left: 20, right: 20, bottom: 20);
}

extension BlurExtension on BuildContext {
  ImageFilter get imageFilter => ImageFilter.blur(sigmaX: 6, sigmaY: 6);
}

extension RadiusExtension on BuildContext {
  BorderRadius get circularRadius => BorderRadius.circular(60);
  BorderRadius get containerRadius => BorderRadius.circular(15);
  BorderRadius get radiusTopLeftTopRigt50 => const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      );
}

extension StringExtension on String {
  String firstUpperCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
  EdgeInsets get paddingLowHorizontalAndVertical =>
      EdgeInsets.symmetric(horizontal: lowValue, vertical: lowValue);
  EdgeInsets get paddingCustomHorizontalAndVertical =>
      EdgeInsets.symmetric(horizontal: width * 0.07, vertical: height * 0.14);
  EdgeInsets get paddingMediumHorizontalAndVertical =>
      EdgeInsets.symmetric(horizontal: mediumValue, vertical: mediumValue);
  EdgeInsets get paddingNormalHorizontalAndVertical =>
      EdgeInsets.symmetric(horizontal: normalValue, vertical: normalValue);
}
