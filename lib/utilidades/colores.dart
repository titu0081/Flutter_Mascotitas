import 'package:flutter/material.dart';

Color kAccentColor = Colors.purple.shade900;
Color kPrimaryColor = Colors.white;
Color kAppBarBackground = Colors.white;
Color kHighlightColor = Colors.red;
Color mFondo = Colors.black.withOpacity(0.8);

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
