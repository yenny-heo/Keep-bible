import 'package:flutter/material.dart';

List lightTextUnselected = [Colors.black, Colors.teal, Colors.orange];
List darkTextUnselected = [Colors.white, Colors.orange, Colors.deepOrange];

List lightTextSelected = [Colors.white, Colors.greenAccent, Colors.orange];
List darkTextSelected = [Colors.black, Colors.amber, Colors.pink];

class AppTheme {
  AppTheme._();

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.blue,
    accentColor: Colors.white,
    primaryColor: Colors.black,


  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Color(0xff8f8f8f),
    accentColor: Colors.black,
    primaryColor: Colors.white,

  );
}