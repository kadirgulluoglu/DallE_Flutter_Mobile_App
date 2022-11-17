import 'package:flutter/cupertino.dart';

class ImageTypeModel {
  final String? title;
  final IconData? icon;
  final String? text;
  bool isSelected;

  ImageTypeModel({this.title, this.icon, this.text, this.isSelected = false});
}
