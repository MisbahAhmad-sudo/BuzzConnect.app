import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
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