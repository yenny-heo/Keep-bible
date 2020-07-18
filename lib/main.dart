import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/navigation/bottom_bar.dart';
import 'package:keep_bible_app/navigation/drawer.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:provider/provider.dart';
import 'local_storage/bookmarks.dart';
import 'local_storage/day_night_mode.dart';
import 'page/new_bible_page.dart';
import 'page/old_bible_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
//  readMode().then((bool m){
//    setMode(m);
//  });
  readSelectedBible().then((List s){
    setSelectedBible(s);
  });
  readBookmark().then((List b){
    setBookmark(b);
  });
  runApp(ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
//      appState.initModeState(isLightOrDark[1]);
      return MaterialApp(
          title: 'Keep Bible',
          theme: appState.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(title: Text('킹제임스 흠정역')),
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
