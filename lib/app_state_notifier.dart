import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  bool getMode() => isDarkMode;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}