import 'package:flutter/material.dart';

List lightTextUnselected = [Colors.black, Colors.green, Colors.deepOrangeAccent];
List darkTextUnselected = [Colors.white, Colors.cyan, Colors.amber];

List lightTextSelected = [Colors.white, Colors.greenAccent, Colors.yellowAccent];
List darkTextSelected = [Colors.black, Colors.cyanAccent, Colors.amberAccent];

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