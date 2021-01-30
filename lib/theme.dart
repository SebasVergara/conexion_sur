
import 'package:flutter/material.dart';

class Style {
  static ThemeData get(bool isDark) {
    Color backgroundColor = isDark ? Color(0xFF434142) : Color(0xFFf2f5fc);
    Color foregroundColor = isDark ? Colors.white : Colors.black;
    Color accentColor = isDark ? Color(0xFF757575) : Color(0xFF474c72);
    Color darkBlue = isDark ? Colors.white : Color(0xFF474c72);
    Color conexionsur = Color(0xFFf58025);
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      backgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      textSelectionColor: isDark ? Colors.white12 : Colors.grey.shade300,
      primaryColor: Color(0xFF4175b7),
      accentColor: accentColor,
      appBarTheme: AppBarTheme(
        color: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: foregroundColor),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: foregroundColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: conexionsur,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          fontFamily: 'Roboto',
        ),
        headline1: TextStyle(
          fontFamily: "Galano",
          fontSize: 32.0,
          fontWeight: FontWeight.w800,
          color: darkBlue,
        ),
        headline3: TextStyle(
          fontFamily: "Galano",
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
        headline5: TextStyle(
          fontFamily: "Galano",
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
      ),
    );
  }
}