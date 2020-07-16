import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  List selectedBible = [true, false];

  bool getMode() => isDarkMode;

  void setMode(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }

  List getSelectedBible() => selectedBible;

  void setSelectedBible(int bible) {
    selectedBible[bible] = !selectedBible[bible];
    print(selectedBible[bible]);
    notifyListeners();
  }
}