import 'package:flutter/material.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:provider/provider.dart';

class Bible{
  final String name;
  final int num;
  Bible(this.name, this.num);
}

Bible b1 = Bible('KJV 흠정역 한글', 0);
Bible b2 = Bible('KJV 흠정역 영어', 1);

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Bible selectedBible = b1;
  List<Bible> bibles = <Bible>[b1, b2];
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getMode();
    final isLightOrDark = [!isDark, isDark];
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.wb_sunny),
                    Icon(Icons.brightness_2)
                  ],
                  onPressed: (int i) {
                    setState(() {
                      isLightOrDark[0] = !isLightOrDark[0];
                      isLightOrDark[1] = !isLightOrDark[1];
                      Provider.of<AppStateNotifier>(context, listen: false).setMode(isLightOrDark[1]);
                    });
                  },
                  isSelected: isLightOrDark,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MenuText('성경 선택'),
            DropdownButton<Bible>(
              value: selectedBible,
              onChanged: (Bible newBible){
                setState(() {
                  selectedBible = newBible;
                  Provider.of<AppStateNotifier>(context, listen: false).setSelectedBible(newBible.num);
                });
              },
              items: bibles.map((Bible bible) {
                return DropdownMenuItem<Bible>(
                  value: bible,
                  child: Text(bible.name)
                );
              }).toList(),

            )
          ],
        )
      ],
    ));
  }
}

Container MenuText(String text) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
    child: Text(text, style: TextStyle(fontSize: 20)),
  );
}
