import 'package:flutter/material.dart';
import 'package:keep_bible_app/bottom_bar.dart';
import 'old_new_bible_list/new_bible.dart';
import 'old_new_bible_list/old_bible.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Bible',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text('킹제임스 성경'))
          ),
          body: TabBarView(
            children: <Widget>[
              OldBible(),
              NewBible(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      )
    );
  }
}
