import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/day_night_mode.dart';
import 'package:keep_bible_app/page/bible_selection_page.dart';
import 'package:keep_bible_app/page/bookmark_page.dart';
import 'package:keep_bible_app/page/highlight_page.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                _menuIcon(Icons.brightness_4, isDark),
                _menuText('모드', isDark),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.wb_sunny),
                    Icon(Icons.brightness_2)
                  ],
                  onPressed: (int i) {
                    setState(() {
                      isLightOrDark[0] = !isLightOrDark[0];
                      isLightOrDark[1] = !isLightOrDark[1];
                      Provider.of<AppStateNotifier>(context, listen: false)
                          .setModeState(isLightOrDark[1]);
                      writeMode(isLightOrDark[1]);
                    });
                  },
                  isSelected: isLightOrDark,
                  color: isDark? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor,
                  selectedBorderColor: Colors.black26,
                  disabledBorderColor: Colors.black26,
                  borderColor: Colors.black26,
                  selectedColor: AppTheme.lightMode.primaryColor,

                ))
          ],
        ),
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
        )
      ],
    ));
  }
}

Container _menuText(String text, bool isDark) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Text(text, style: TextStyle(
        fontSize: 20,
      color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
    )),
  );
}

Container _menuIcon(IconData icon, bool isDark){
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Icon(icon, color: isDark ? Colors.white:Colors.black,),
  );
}