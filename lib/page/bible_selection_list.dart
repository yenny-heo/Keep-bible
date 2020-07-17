import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
            title: _title('KJV 흠정역 한글'),
            leading: Checkbox(
              value: selectedBible[0],
              onChanged: (val){
                setState((){
                  //List sb = Provider.of<AppStateNotifier>(context, listen: false).getSelectedBible();
                  if(selectedBible[0] == true && selectedBible[1] == false)
                    {
                      leastOneBible();
                    }
                  else{
                   // Provider.of<AppStateNotifier>(context, listen: false).setSelectedBible(0);
                    writeSelectedBible(0);
                  }
                });
              },
            )
          ),
          ListTile(
              title: _title('KJV 흠정역 영어'),
              leading: Checkbox(
                value: selectedBible[1],
                onChanged: (val){
                  setState((){
                    //List sb = Provider.of<AppStateNotifier>(context, listen: false).getSelectedBible();
                    if(selectedBible[0] == false && selectedBible[1] == true)
                      {
                        leastOneBible();
                      }
                    else{
                     // Provider.of<AppStateNotifier>(context, listen: false).setSelectedBible(1);
                      writeSelectedBible(1);
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
      msg: "최소 하나 이상의 역본을 선택해야 합니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

Text _title(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 20),
  );
}