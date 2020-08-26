import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/day_night_mode.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double fontSize = 21;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _menuText('테마 설정', isDark, 20),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ToggleButtonsTheme(
                    data: ToggleButtonsTheme.of(context).copyWith(
                      color: isDark? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor,
                      selectedBorderColor: Colors.black26,
                      disabledBorderColor: Colors.black26,
                      borderColor: Colors.black26,
                      selectedColor: AppTheme.lightMode.primaryColor,
                      fillColor: Color(0xff33546fee),
                    ),
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
                    )
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _menuText('글자 크기', isDark, 20),
              Row(
                children: <Widget>[
                  _Stext('A', isDark, 15),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Color(0xff546fee),
                      activeTrackColor: Color(0xffB3546fee),
                      activeTickMarkColor: Colors.white54,
                      inactiveTrackColor: Color(0xffB3546fee),
                      inactiveTickMarkColor: Colors.white54
                    ),
                    child: Slider(
                      value: fontSize,
                      min: 15,
                      max: 27,
                      divisions: 4,
                      onChanged: (double val){
                        setState(() {
                          fontSize = val;
                        });
                      },
                    ),
                  ),
                  _Btext('A', isDark, 27),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            width: 100,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
              ),
            ),
            child: _menuText('처음에 하나님께서 하늘과 땅을 창조하시니라.\nIn the beginning God created the heaven and the earth.', isDark, fontSize),
          )
        ],
      )
    );
  }
}
Container _menuText(String text, bool isDark, double size) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Text(text, style: TextStyle(
        fontSize: size,
        color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
    )),
  );
}

Container _Stext(String text, bool isDark, double size) {
  return Container(
    child: Text(text, style: TextStyle(
        fontSize: size,
        color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
    )),
  );
}

Container _Btext(String text, bool isDark, double size) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Text(text, style: TextStyle(
        fontSize: size,
        color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
    )),
  );
}