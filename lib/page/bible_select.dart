import 'package:flutter/material.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool _value0 = true;
bool _value1 = false;

class BibleSelection extends StatefulWidget{
  _BibleSelectionState createState() => _BibleSelectionState();
}

class _BibleSelectionState extends State<BibleSelection>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('역본 선택')),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('KJV 흠정역 한글'),
            leading: Checkbox(
              value: _value0,
              onChanged: (val){
                setState((){
                  List sb = Provider.of<AppStateNotifier>(context, listen: false).getSelectedBible();
                  if(sb[0] == true && sb[1] == false)
                    {
                      leastOneBible();
                    }
                  else{
                    Provider.of<AppStateNotifier>(context, listen: false).setSelectedBible(0);
                    _value0 = sb[0];
                  }
                });
              },
            )
          ),
          ListTile(
              title: Text('KJV 흠정역 영어'),
              leading: Checkbox(
                value: _value1,
                onChanged: (val){
                  setState((){
                    List sb = Provider.of<AppStateNotifier>(context, listen: false).getSelectedBible();
                    if(sb[0] == false && sb[1] == true)
                      {
                        leastOneBible();
                      }
                    else{
                      Provider.of<AppStateNotifier>(context, listen: false).setSelectedBible(1);
                      _value1 = sb[1];
                    }
                  });
                },
              )
          ),
        ],
      )
    );
  }

}

Future<bool> leastOneBible() {
  return Fluttertoast.showToast(
      msg: "최소 하나 이상의 역본을 선택해주세요.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}