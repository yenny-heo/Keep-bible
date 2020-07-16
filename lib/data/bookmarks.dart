import 'dart:convert';
import 'dart:io';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:path_provider/path_provider.dart';

var bookMarks = List();

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/bookMarks.txt');
}

Future<File> writeBookmark(List bookMarks) async {
  final file = await _localFile;
  // Write the file.
  return file.writeAsString('$bookMarks');
}

Future<List> readBookmark() async {
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

void _initBookMarks(){
  for(int i=0; i<66; i++){
    bookMarks.add([]);
    for(int j=0; j<korhkjv[i].length; j++){
      bookMarks[i].add([false]);
    }
  }
}

void setBookmark(List bookmark){
  if(bookmark != null) {
    print(bookmark);
    bookMarks = bookmark;
  }
  else{
    print("init");
    _initBookMarks();
  }
}