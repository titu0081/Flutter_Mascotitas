import 'package:flutter/material.dart';

class TemaAplicacion {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 45.0, fontWeight: FontWeight.w700, color: Colors.black),
      displayLarge: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.black),
      displayMedium: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),
      titleLarge: TextStyle(
          fontSize: 25.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 255, 255, 255)),
      bodyMedium: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Hind',
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
  );
}
