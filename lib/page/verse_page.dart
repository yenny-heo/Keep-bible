import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/korhrv.dart';
import 'package:keep_bible_app/local_storage/bookmarks.dart';
import 'package:keep_bible_app/data/engkjv.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:keep_bible_app/toast/toast.dart';
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

    List bible = [];
    if (selectedBible[0] == true) {
      bible.add(korhkjv);
    }
    if (selectedBible[1] == true) {
      bible.add(engkjv);
    }
    if (selectedBible[2] == true) {
      bible.add(korhrv);
    }

    final fixedList = Iterable<int>.generate(bible[0][widget.book].length).toList();

    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    bookMarks[widget.book][widget.chapter][0] ? bookMarkIcon = Icons.bookmark : bookMarkIcon = Icons.bookmark_border;

    Future<File> _setBookmark() {
      bool flag = bookMarks[widget.book][widget.chapter][0];
      setState(() {
        bookMarks[widget.book][widget.chapter][0] = !flag;
        flag ? bookMarkIcon = Icons.bookmark: bookMarkIcon = Icons.bookmark_border;
      });
      if(!flag)
        toast("책갈피를 추가했습니다.");
      else
        toast("책갈피가 삭제되었습니다.");

      return writeBookmark(bookMarks);
    }

    void _showDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: 1000,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: fixedList.map((val) {
                    return MaterialButton(
                        onPressed: () {
                          setState(() {
                            widget.chapter = val;
                            bookMarks[widget.book][widget.chapter][0]
                                ? bookMarkIcon = Icons.bookmark
                                : bookMarkIcon = Icons.bookmark_border;
                            Navigator.pop(context);
                          });
                        },
                        color: isDark? AppTheme.darkMode.scaffoldBackgroundColor: AppTheme.lightMode.scaffoldBackgroundColor,
                        minWidth: 0,
                        height: 0,
                        padding: EdgeInsets.zero,
                        child: Text('${val + 1}', style: TextStyle(fontSize: 20),)
                    );
                  }).toList(),
                ),
              )
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.name)),
          actions: <Widget>[
            MaterialButton(
              minWidth: 50,
              height: 10,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              child:Row(
                children: <Widget>[
                  Text('${widget.chapter+1} 장', style: TextStyle(fontSize: 18),),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
                onPressed: () => _showDialog(),
              ),
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
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
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
              return Container(
                decoration: BoxDecoration(
                    color: widget.selected[i]
                        ? mode.scaffoldBackgroundColor
                        : mode.accentColor,
                    border: Border(
                        bottom:
                        BorderSide(color: Colors.grey, width: 2))),
                child: ListView.builder(
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
                  }));
            }));
  }
}
