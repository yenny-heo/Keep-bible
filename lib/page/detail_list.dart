import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_bible_app/data/bookmarks.dart';
import 'package:keep_bible_app/data/engkjv.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class DetailScreen extends StatefulWidget {
  final String name;
  final int book;
  int chapter;

  DetailScreen({Key key, this.name, this.book, this.chapter}) : super(key: key);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  IconData bookMarkIcon;

  @override
  Widget build(BuildContext context) {
    List selectedBible = Provider.of<AppStateNotifier>(context, listen: false)
        .getSelectedBible();

    List bible = [];
    if (selectedBible[0] == true) {
      bible.add(korhkjv);
    }
    if (selectedBible[1] == true) {
      bible.add(engkjv);
    }
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getMode();
    bookMarks[widget.book][widget.chapter][0] ? bookMarkIcon = Icons.bookmark : bookMarkIcon = Icons.bookmark_border;

    Future<File> _setBookmark() {
      bool flag = bookMarks[widget.book][widget.chapter][0];
      setState(() {
        bookMarks[widget.book][widget.chapter][0] = !flag;
        flag ? bookMarkIcon = Icons.bookmark: bookMarkIcon = Icons.bookmark_border;
      });
      if(!flag)
        Fluttertoast.showToast(
            msg: "책갈피를 추가했습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      else
        Fluttertoast.showToast(
            msg: "책갈피가 삭제되었습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

      return writeBookmark(bookMarks);
    }

    final fixedList = Iterable<int>.generate(bible[0][widget.book].length)
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.name)),
          actions: <Widget>[
            DropdownButton<int>(
                value: widget.chapter,
                dropdownColor: Colors.indigo,
                style: TextStyle(color: Colors.white, fontSize: 18),
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (int i) {
                  setState(() {
                    widget.chapter = i;
                    bookMarks[widget.book][widget.chapter][0]
                        ? bookMarkIcon = Icons.bookmark
                        : bookMarkIcon = Icons.bookmark_border;
                  });
                },
                items: fixedList.map((i) {
                  int a = i + 1;
                  return DropdownMenuItem<int>(value: i, child: Text('$a 장'));
                }).toList()),
            ToggleButtons(
              children: <Widget>[Icon(bookMarkIcon)],
              onPressed: (int i) => _setBookmark(),
              isSelected: bookMarks[widget.book][widget.chapter].cast<bool>(),
              fillColor: isDark
                  ? ThemeData.dark().primaryColor
                  : ThemeData.light().primaryColor,
              selectedColor: isDark
                  ? AppTheme.darkMode.primaryColor
                  : AppTheme.lightMode.primaryColor,
              borderColor: isDark
                  ? ThemeData.dark() .primaryColor
                  : ThemeData.light().primaryColor,
              selectedBorderColor: isDark
                  ? ThemeData.dark().primaryColor
                  : ThemeData.light().primaryColor,
            )
          ],
        ),
        body: VerseList(
            bible: bible,
            book: widget.book,
            chapter: widget.chapter,
            selected: List.generate(bible[0][widget.book][widget.chapter].length, (index) => false)));
  }
}

class VerseList extends StatefulWidget {
  final List bible;
  final int book;
  final int chapter;
  final List selected;

  const VerseList({Key key, this.bible, this.book, this.chapter, this.selected})
      : super(key: key);

  @override
  _VerseListState createState() => _VerseListState();
}

class _VerseListState extends State<VerseList> {
  @override
  Widget build(BuildContext context) {
    bool isDark =
        Provider.of<AppStateNotifier>(context, listen: false).getMode();
    ThemeData mode;
    List selectedColors;
    List unSelectedColors;
    if(isDark){
      mode = AppTheme.darkMode;
      selectedColors = darkTextSelected;
      unSelectedColors = darkTextUnselected;
    }
    else{
      mode = AppTheme.lightMode;
      selectedColors = lightTextSelected;
      unSelectedColors = lightTextUnselected;
    }
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.bible[0][widget.book][widget.chapter].length,
            itemBuilder: (context, i) {
              int n = i + 1;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.bible.length,
                  itemBuilder: (context2, j) {
                    return Container(
                        decoration: BoxDecoration(
                            color: widget.selected[i]
                                ? mode.scaffoldBackgroundColor
                                : mode.accentColor,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1))),
                        child: ListTile(
                          leading: Text(
                            '$n',
                            style: TextStyle(
                                fontSize: 18,
                                color: widget.selected[i]
                                    ? selectedColors[j]
                                    : unSelectedColors[j]),
                          ),
                          title: Text(
                            widget.bible[j][widget.book][widget.chapter][i],
                            style: TextStyle(
                                fontSize: 22,
                                color: widget.selected[i]
                                    ? selectedColors[j]
                                    : unSelectedColors[j]),
                          ),
                          onTap: () {
                            setState(() {
                              widget.selected[i] = !widget.selected[i];
                            });
                          },
                        ));
                  });
            }));
  }
}
