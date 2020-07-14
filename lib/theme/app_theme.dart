import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.blue,
    accentColor: Colors.white,
    primaryColor: Colors.black,

  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.blue,
    accentColor: Colors.black,
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}