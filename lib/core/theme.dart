import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color.fromARGB(221, 181, 177, 177),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 61, 60, 60))),
      textTheme: const TextTheme(
          titleSmall: TextStyle(color: Color.fromARGB(255, 145, 141, 141))));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      cardColor: const Color.fromARGB(221, 116, 114, 114),
      appBarTheme: const AppBarTheme(color: Colors.black),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 211, 209, 209))),
      textTheme: const TextTheme(
          bodySmall: TextStyle(color: Color.fromARGB(255, 201, 198, 198))));
}
