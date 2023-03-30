import 'package:flutter/material.dart';

class ReampColors {
  static Color primary = const Color(0xFFF5BF97);
  static Color secondary = const Color(0xFFF48E59);

  static Color primaryAccent = const Color(0xFFA8CDFA);
  static Color secondaryAccent = const Color(0xFFD6E0EB);

  static Color warning = const Color(0xFFFA584E);

  static Color textDeep = const Color(0xFF1F3750);
  static Color textMedium = const Color(0xFF566E88);
  static Color textBright = const Color(0xFF398EF5);

  static Color background = const Color(0xFFE7EDF4);
  static Color backgroundBright = const Color(0x3EFFFFFF);
}

class ReampText {
  static String fontFamily = "Lato";

  static final TextTheme theme = TextTheme(
    headline1: TextStyle(
      fontSize: 30, // ? Change back to 32?
      height: 36/32,
      color: ReampColors.textDeep,
      fontWeight: FontWeight.w500,
    ),
    headline2: TextStyle(
      fontSize: 24,
      height: 33/24,
      color: ReampColors.textDeep,
      fontWeight: FontWeight.w500,
    ),
    button: TextStyle(
      fontSize: 18,
      color: ReampColors.textDeep,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      height: 22/16,
      color: ReampColors.textDeep,
      fontWeight: FontWeight.w500,
    ),
    caption: TextStyle(
      fontSize: 14,
      height: 18/14,
      color: ReampColors.textMedium,
    ),
  );
}

class ReampTheme {
  static final ThemeData reampTheme = ThemeData(
    scaffoldBackgroundColor: ReampColors.background,
    primaryColor: ReampColors.primary,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(ReampColors.primary),
    ),
    textTheme: ReampText.theme,
    fontFamily: ReampText.fontFamily,
  );
}
