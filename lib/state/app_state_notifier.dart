import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  List selectedBible = [true, false];

  bool getModeState() => isDarkMode;

  void setModeState(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
  void initModeState(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    print(isDarkMode);
  }

  List getSelectedBibleState() => selectedBible;

  void setSelectedBibleState(int bible) {
    selectedBible[bible] = !selectedBible[bible];
    notifyListeners();
  }
}