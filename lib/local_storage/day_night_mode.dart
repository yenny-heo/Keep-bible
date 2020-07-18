//버그로 인해 사용 X
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//0: light, 1: dark
var isLightOrDark = [true, false];

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/mode.txt');
}

Future<File> writeMode(bool isDark) async {
  final file = await _localFile;
  // Write the file.
  return file.writeAsString('$isDark');
}

Future<bool> readMode() async {
  try {
    final file = await _localFile;
    // Read the file.
    String contents = await file.readAsString();
    return contents == "true";
  } catch (e) {
    // If encountering an error, return 0.
    return false;
  }
}

void setMode(bool isDark){
  print("dark"+isDark.toString());
  isLightOrDark[0] = !isDark;
  isLightOrDark[1] = isDark;
}