import 'package:flutter/material.dart';

Color kAccentColor = Colors.purple.shade900;
Color kPrimaryColor = Colors.white;
Color kAppBarBackground = Colors.white;
Color kHighlightColor = Colors.red;
Color mFondo = const Color.fromARGB(255, 1, 16, 100).withOpacity(0.8);
Color recientesF = const Color.fromARGB(255, 10, 136, 145);
Color iconoS = const Color.fromARGB(197, 8, 128, 18);
Color modeloC1 = const Color.fromARGB(255, 0, 2, 255);
Color modeloC2 = const Color.fromARGB(255, 12, 107, 131);
Color dropD = const Color.fromARGB(213, 0, 162, 255);

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
