import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/day_night_mode.dart';
import 'package:keep_bible_app/page/bible_selection_page.dart';
import 'package:keep_bible_app/page/bookmark_page.dart';
import 'package:keep_bible_app/page/highlight_page.dart';
import 'package:keep_bible_app/page/setting_page.dart';
import 'package:keep_bible_app/page/search_page.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';



class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  @override
  Widget build(BuildContext context) {
    bool isDark =
        Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    return Drawer(
        child: ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
            height: 100,
            child: DrawerHeader(
              decoration:
                  BoxDecoration(color: isDark ? AppTheme.darkMode.primaryColor : AppTheme.lightMode.primaryColor),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )),
        InkWell(
          child: Row(
            children: <Widget>[
              _menuIcon(Icons.library_books, isDark),
              _menuText('역본 선택', isDark),
            ],
          ),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BibleSelection()))
          }
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              _menuIcon(Icons.bookmark, isDark),
              _menuText('책갈피 목록', isDark),
            ],
          ),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookmarkList()))
          },
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              _menuIcon(Icons.border_color, isDark),
              _menuText('밑줄 목록', isDark),
            ],
          ),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HighlightList()))
          },
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              _menuIcon(Icons.search, isDark),
              _menuText('검색', isDark),
            ],
          ),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchPage()))
          },
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              _menuIcon(Icons.settings, isDark),
              _menuText('설정', isDark),
            ],
          ),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage()))
          },
        ),
      ],
    ));
  }
}

Container _menuText(String text, bool isDark) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Text(text, style: TextStyle(
        fontSize: 20,
      color: isDark? AppTheme.darkMode.hintColor : AppTheme.lightMode.hintColor
    )),
  );
}

Container _menuIcon(IconData icon, bool isDark){
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Icon(icon, color: isDark ? Colors.white:Colors.black,),
  );
}