import 'package:flutter/material.dart';
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

  const DetailScreen({Key key, this.name, this.book}) : super(key: key);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int chapter = 0;
  IconData bookMarkIcon;

  @override
  Widget build(BuildContext context) {
    int bibleNum = Provider.of<AppStateNotifier>(context, listen: false)
        .getSelectedBible();
    List bible = korhkjv;
    bool isDark =
        Provider.of<AppStateNotifier>(context, listen: false).getMode();
    bookMarks[widget.book][chapter][0]
        ? bookMarkIcon = Icons.bookmark
        : bookMarkIcon = Icons.bookmark_border;
    switch (bibleNum) {
      case 0:
        bible = korhkjv;
        break;
      case 1:
        bible = engkjv;
        break;
    }
    Future<File> _setBookmark() {
      setState(() {
        bookMarks[widget.book][chapter][0] =
            !bookMarks[widget.book][chapter][0];
        bookMarks[widget.book][chapter][0]
            ? bookMarkIcon = Icons.bookmark
            : bookMarkIcon = Icons.bookmark_border;
      });

      print(bookMarks[widget.book][chapter]);
      return writeBookmark(bookMarks);
    }

    final fixedList =
        Iterable<int>.generate(bible[widget.book].length).toList();

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
                    bookMarks[widget.book][chapter][0]
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
              isSelected: bookMarks[widget.book][chapter].cast<bool>(),
              fillColor: isDark
                  ? ThemeData.dark().primaryColor
                  : ThemeData.light().primaryColor,
              selectedColor: isDark
                  ? AppTheme.darkMode.primaryColor
                  : AppTheme.lightMode.primaryColor,
              borderColor: isDark
                  ? ThemeData.dark().primaryColor
                  : ThemeData.light().primaryColor,
              selectedBorderColor: isDark
                  ? ThemeData.dark().primaryColor
                  : ThemeData.light().primaryColor,
            )
          ],
        ),
        body: VerseList(
          verses: List.generate(bible[widget.book][chapter].length,
              (i) => (bible[widget.book][chapter][i])),
          selected:
              List.generate(bible[widget.book][chapter].length, (i) => (false)),
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
            bool isDark =
                Provider.of<AppStateNotifier>(context, listen: false).getMode();
            ThemeData mode = AppTheme.lightMode;
            isDark ? mode = AppTheme.darkMode : mode = AppTheme.lightMode;
            return Container(
                decoration: BoxDecoration(
                    color: widget.selected[i]
                        ? mode.scaffoldBackgroundColor
                        : mode.accentColor,
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1))),
                child: ListTile(
                  leading: Text('$n',
                      style: TextStyle(
                          fontSize: 20,
                          color: widget.selected[i]
                              ? mode.accentColor
                              : mode.primaryColor)),
                  title: Text(
                    verse,
                    style: TextStyle(
                        fontSize: 22,
                        color: widget.selected[i]
                            ? mode.accentColor
                            : mode.primaryColor),
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
