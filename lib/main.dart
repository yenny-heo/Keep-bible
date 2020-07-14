import 'package:flutter/material.dart';
import 'package:keep_bible_app/app_state_notifier.dart';
import 'package:keep_bible_app/bottom_bar.dart';
import 'package:keep_bible_app/drawer.dart';
import 'package:provider/provider.dart';
import 'old_new_bible_list/new_bible.dart';
import 'old_new_bible_list/old_bible.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(), child: MyApp()));
}
//
//class MyApp extends StatefulWidget {
//  _MyAppState createState() => _MyAppState();
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
          title: 'Keep Bible',
          theme: appState.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(title: Text('킹제임스 성경')),
              drawer: NavDrawer(),
              body: TabBarView(
                children: <Widget>[
                  OldBible(),
                  NewBible(),
                ],
              ),
              bottomNavigationBar: Bottom(),
            ),
          ));
    });
  }
}
