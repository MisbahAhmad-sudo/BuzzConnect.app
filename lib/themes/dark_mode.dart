import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      color:Colors.black,
      fontFamily: "Poppins",
      fontWeight:FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 25,
      color:Colors.black,
      fontFamily: "Poppins",
      fontWeight:FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 15,
      color:Colors.black,
      fontFamily: "Poppins",
      fontWeight:FontWeight.w600,
    ),

  ),
);