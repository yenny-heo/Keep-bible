import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  int selectedBible = 0;

  bool getMode() => isDarkMode;

  void setMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }

  int getSelectedBible() => selectedBible;

  void setSelectedBible(int bible) {
    this.selectedBible = bible;
    notifyListeners();
  }
}