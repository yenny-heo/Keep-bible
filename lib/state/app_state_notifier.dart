import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  List selectedBible = [true, false];

  bool getMode() => isDarkMode;

  void setMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
  void initMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
  }

  List getSelectedBible() => selectedBible;

  void setSelectedBible(int bible) {
    selectedBible[bible] = !selectedBible[bible];
    notifyListeners();
  }
}