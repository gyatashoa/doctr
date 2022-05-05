import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final defualtTextStyle = GoogleFonts.ptSans(
      fontWeight: FontWeight.w500,
    );
    return ThemeData(
        primaryTextTheme: TextTheme(
            bodySmall: defualtTextStyle,
            bodyLarge: defualtTextStyle,
            displayMedium: defualtTextStyle,
            displaySmall: defualtTextStyle,
            displayLarge: defualtTextStyle,
            bodyMedium: defualtTextStyle),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => defualtTextStyle),
        )),
        textTheme: TextTheme(
          subtitle1: defualtTextStyle,
          // bodySmall: defualtTextStyle,
          // bodyLarge: defualtTextStyle,
          // displayMedium: defualtTextStyle,
          // displaySmall: defualtTextStyle,
          // displayLarge: defualtTextStyle,
          // bodyMedium: defualtTextStyle
        ));
  }
}
