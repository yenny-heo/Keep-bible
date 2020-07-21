import 'package:flutter/material.dart';

List lightTextUnselected = [Colors.black, Colors.green, Colors.orange];
List lightTextSelected = [Colors.white, Colors.greenAccent, Colors.yellowAccent];

List darkTextUnselected = [Colors.white, Colors.cyan, Colors.amber];
List darkTextSelected = [Colors.black, Colors.cyanAccent, Colors.amberAccent];

class AppTheme {
  AppTheme._();

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.black,
    primaryColor: Color(0xff546fee),
    canvasColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    focusColor: Color(0xff546fee)


  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Color(0xff3b3b3b),
    accentColor: Colors.white,
    primaryColor: Color(0xff303030),
    canvasColor: Color(0xff3b3b3b),//drawer background
    dialogBackgroundColor: Color(0xff303030),
    focusColor: Color(0xff919191),



  );
}