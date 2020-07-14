import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.blue,
    accentColor: Colors.white,
    primaryColor: Colors.black,

  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.white54,
    accentColor: Colors.black,
    primaryColor: Colors.white,

  );
}