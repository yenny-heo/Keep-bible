import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/day_night_mode.dart';
import 'package:keep_bible_app/page/bible_selection_page.dart';
import 'package:keep_bible_app/page/bookmark_page.dart';
import 'package:keep_bible_app/page/search_page.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
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
            height: 85,
            child: DrawerHeader(
              decoration:
                  BoxDecoration(color: isDark ? Colors.black38 : Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MenuText('모드'),
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
                ))
          ],
        ),
        InkWell(
          child: MenuText('역본 선택'),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BibleSelection()))
          }
        ),
        InkWell(
          child: MenuText('책갈피 목록'),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookmarkList()))
          },
        ),
        InkWell(
          child: MenuText('검색'),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchPage()))
          },
        )
      ],
    ));
  }
}

Container MenuText(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Text(text, style: TextStyle(fontSize: 20)),
  );
}
