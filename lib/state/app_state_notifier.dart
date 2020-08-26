import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkMode = false;
  List selectedBible = [true, false, false];
  double fontSize = 21;

  //mode
  bool getModeState() => isDarkMode;

  void setModeState(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
  void initModeState(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
  }

  //selected bible
  List getSelectedBibleState() => selectedBible;

  void setSelectedBibleState(int bible) {
    selectedBible[bible] = !selectedBible[bible];
    notifyListeners();
  }

  void initSelectedBibleState(List s){
    s = s.cast<bool>();
    for(int i=0; i<s.length; i++){
      selectedBible[i] = s[i];
    }
  }

  //font size
  double getFontSizeState() => fontSize;

  void setFontSizeState(double size){
    fontSize = size;
    notifyListeners();
  }

  void initFontSizeState(double size){
    fontSize = size;
  }
}