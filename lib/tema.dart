import 'package:flutter/material.dart';

class TemaAplicacion {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 25.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 255, 255, 255)),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
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
