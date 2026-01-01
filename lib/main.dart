import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/font_size.dart';
import 'package:keep_bible_app/local_storage/highlighted_verses.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/navigation/bottom_bar.dart';
import 'package:keep_bible_app/navigation/drawer.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'local_storage/bookmarks.dart';
import 'local_storage/day_night_mode.dart';
import 'page/new_bible_page.dart';
import 'page/old_bible_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  readBookmark().then((List? b) {
    setBookmark(b);
  });
  readHighlight().then((List? h) {
    setHighlight(h);
  });
  runApp(ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    readMode().then((bool m) {
      setMode(m); //initialize
      Provider.of<AppStateNotifier>(context, listen: false)
          .setModeState(isLightOrDark[1]);
    });
    readSelectedBible().then((List s) {
      setSelectedBible(s); //initialize
      Provider.of<AppStateNotifier>(context, listen: false)
          .initSelectedBibleState(s);
    });
    readFontSize().then((double s) {
      setFontSize(s);
      Provider.of<AppStateNotifier>(context, listen: false)
          .initFontSizeState(s);
    });
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
          title: 'Keep Bible',
          debugShowCheckedModeBanner: false,
          theme: appState.isDarkMode ? AppTheme.darkMode : AppTheme.lightMode,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  title: Text('킹제임스 흠정역'),
                  foregroundColor: Colors.white,
                  backgroundColor: appState.isDarkMode
                      ? AppTheme.darkMode.primaryColor
                      : AppTheme.lightMode.primaryColor),
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
