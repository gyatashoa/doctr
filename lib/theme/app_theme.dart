import 'package:doctr/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final defualtTextStyle = GoogleFonts.ptSans(
      fontWeight: FontWeight.w500,
    );
    return ThemeData(
        primaryColor: primaryColor,
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.shifting,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.black45,
            selectedIconTheme: IconThemeData(color: Colors.black)),
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
