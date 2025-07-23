import 'package:flutter/material.dart';

class ThemeHelper {
  ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "pop",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: Colors.transparent),
      cardColor: Color(0xff2C2C2C),
      cardTheme: CardThemeData(color: Color(0xff2C2C2C)),
      shadowColor: Color(0xffE424242),
      colorScheme:ColorScheme.dark(brightness: Brightness.dark,primary: Color(0xFF1E88E5)),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 29,
          fontWeight: FontWeight.w600,
          color: Color(0xffFAFAFA),
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Color(0xffFAFAFA),
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xffFAFAFA),
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xffB0BEC5),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xff90A4AE),
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xffFFFFFF),
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xffFF5252),
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Color(0xff90CAF9),
        ),
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      colorScheme:ColorScheme.light(brightness: Brightness.light,primary: Color(0xFF1E88E5)),
      cardColor: Color(0xffFFFFFF),
      fontFamily: "pop",
      brightness: Brightness.light,
      cardTheme: CardThemeData(color: Color(0xffFFFFFF)),
      shadowColor: Color(0xffE0E0E0),
      appBarTheme: AppBarTheme(color: Colors.transparent),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 29,
          fontWeight: FontWeight.w600,
          color: Color(0xff212121),
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Color(0xff212121),
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xff212121),
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff424242),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xff757575),
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xffFFFFFF),
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xffFF3D00),
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Color(0xff1E88E5),
        ),
      ),
    );
  }
}
