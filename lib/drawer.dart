import 'package:flutter/material.dart';
import 'package:keep_bible_app/app_state_notifier.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getMode();
    final isLightOrDark = [!isDark, isDark];
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Text(
              'Menu',
              style: TextStyle(fontSize: 25),
            )),
            Center(
              child:ToggleButtons(
                children: <Widget>[
                  Icon(Icons.wb_sunny),
                  Icon(Icons.brightness_2)
                ],
                onPressed: (int i) {
                  setState(() {
                    isLightOrDark[0] = !isLightOrDark[0];
                    isLightOrDark[1] = !isLightOrDark[1];
                    Provider.of<AppStateNotifier>(context, listen: false).updateTheme(isLightOrDark[1]);
                  });
                },
                isSelected: isLightOrDark,
              )
            )
          ],
    ));
  }
}
