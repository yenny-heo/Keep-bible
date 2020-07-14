import 'package:flutter/material.dart';
import 'package:keep_bible_app/app_state_notifier.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final int book;

  const DetailScreen({Key key, this.name, this.book}) : super(key: key);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int chapter = 0;

  @override
  Widget build(BuildContext context) {
    final fixedList = Iterable<int>.generate(korhkjv[widget.book].length).toList();
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.name)),
          actions: <Widget>[
            DropdownButton<int>(
                value: chapter,
                dropdownColor: Colors.indigo,
                style: TextStyle(color: Colors.white, fontSize: 18),
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (int i) {
                  setState(() {
                    chapter = i;
                  });
                },
                items: fixedList.map((i) {
                  int a = i + 1;
                  return DropdownMenuItem<int>(value: i, child: Text('$a 장'));
                }).toList()),
//            DropdownButton<int>(
//                value: chapter,
//                dropdownColor: Colors.indigo,
//                style: TextStyle(color: Colors.white, fontSize: 18),
//                icon: Icon(Icons.arrow_drop_down),
//                onChanged: (int i) {
//                  setState(() {
//                    chapter = i;
//                  });
//                },
//                items: fixedList.map((i) {
//                  int a = i + 1;
//                  return DropdownMenuItem<int>(value: i, child: Text('$a 장'));
//                }).toList())
          ],
        ),
        body: VerseList(
          verses: List.generate(korhkjv[widget.book][chapter].length,
              (i) => (korhkjv[widget.book][chapter][i])),
          selected:
              List.generate(korhkjv[widget.book][chapter].length, (i) => (false)),
        ));
  }
}

class VerseList extends StatefulWidget {
  final List<String> verses;
  final List<bool> selected;

  const VerseList({Key key, this.verses, this.selected}) : super(key: key);

  @override
  _VerseListState createState() => _VerseListState();
}

class _VerseListState extends State<VerseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.verses.length,
          itemBuilder: (context, i) {
            String verse = widget.verses[i];
            int n = i + 1;
            bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getMode();
            ThemeData mode = AppTheme.lightMode;
            isDark ? mode=AppTheme.darkMode : mode=AppTheme.lightMode;
            return Container(
                decoration: BoxDecoration(
                    color: widget.selected[i] ? mode.scaffoldBackgroundColor : mode.accentColor,
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                child: ListTile(
                  leading: Text('$n', style: TextStyle(fontSize: 20, color: widget.selected[i] ? mode.accentColor : mode.primaryColor)),
                  title: Text(
                    verse,
                    style: TextStyle(fontSize: 22, color: widget.selected[i] ? mode.accentColor : mode.primaryColor),
                  ),
                  onTap: () {
                    setState(() {
                      widget.selected[i] = !widget.selected[i];
                    });
                  },
                ));
          }),
    );
  }
}
