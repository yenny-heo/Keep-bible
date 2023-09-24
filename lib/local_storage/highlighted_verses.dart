import 'dart:convert';
import 'dart:io';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:path_provider/path_provider.dart';

var highlights = <dynamic>[];

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/highlights.txt');
}

Future<File> writeHighlight(List highlights) async {
  final file = await _localFile;
  // Write the file.
  return file.writeAsString('$highlights');
}

Future<List?> readHighlight() async {
  try {
    final file = await _localFile;
    // Read the file.
    String contents = await file.readAsString();
    return json.decode(contents);
  } catch (e) {
    // If encountering an error, return 0.
    return null;
  }
}

void _initHighlights() {
  //성경 역본 개수
  for (int i = 0; i < 66; i++) {
    highlights.add([]);
    for (int j = 0; j < korhkjv[i].length; j++) {
      highlights[i].add([]);
      for (int k = 0; k < korhkjv[i][j].length; k++) {
        highlights[i][j].add(false);
      }
    }
  }
}

void setHighlight(List? highlight){
  if(highlight != null && highlight.length == 66) {
    highlights = highlight;
  }
  else{
    _initHighlights();
  }
}