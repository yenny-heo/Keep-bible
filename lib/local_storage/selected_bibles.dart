import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

var selectedBible = [true, false];

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/selectedBible.txt');
}

Future<File> writeSelectedBible(int num) async {
  final file = await _localFile;
  selectedBible[num] = !selectedBible[num];
  // Write the file.
  return file.writeAsString('$selectedBible');
}

Future<List> readSelectedBible() async {
  try {
    final file = await _localFile;
    // Read the file.
    String contents = await file.readAsString();
    return json.decode(contents);
  } catch (e) {
    // If encountering an error, return 0.
    return [true, false];
  }
}

void setSelectedBible(List s){
  selectedBible = s.cast<bool>();
}