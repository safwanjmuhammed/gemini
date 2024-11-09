import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0XFFFAFAFA),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromARGB(255, 201, 198, 198)),
      cardColor: const Color(0XFFD2D3DB),
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 61, 60, 60))),
      textTheme: const TextTheme(
        titleSmall: TextStyle(
          color: Color.fromARGB(255, 145, 141, 141),
        ),
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF404258),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromARGB(255, 201, 198, 198)),
      cardColor: const Color(0xFF50577A),
      appBarTheme: const AppBarTheme(color: Color(0xFF404258)),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 211, 209, 209))),
      textTheme: const TextTheme(
          bodySmall: TextStyle(color: Color.fromARGB(255, 201, 198, 198)),
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          )));
}
