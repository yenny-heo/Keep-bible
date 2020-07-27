import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/data/title.dart';
import 'package:keep_bible_app/local_storage/highlighted_verses.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'verse_page.dart';

List<HighlightInfo> highlightList = List<HighlightInfo>();

class HighlightInfo {
  String fullContent;
  String bookName;
  int book;
  int chapter;
  int verse;
  HighlightInfo(fullContent, bookName, book, chapter, verse) {
    this.fullContent = fullContent;
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
    this.verse = verse;
  }
}

class HighlightList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark =
    Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    highlightList = [];
    for (int i = 0; i < highlights.length; i++) {
      for (int j = 0; j < highlights[i].length; j++) {
        for (int k = 0; k < highlights[i][j].length; k++){
          if(highlights[i][j][k]){
            String fullContent, bookName;
            if (i <= 38) {
              //구약
              fullContent = korOldB[i] + " " + (j + 1).toString() + ":" + (k+1).toString();
              bookName = korOldB[i];
            } else {
              fullContent = korNewB[i - 39] + " " + (j + 1).toString() + ":" + (k+1).toString();
              bookName = korNewB[i - 39];
            }
            fullContent += " " + korhkjv[i][j][k];
            HighlightInfo h = HighlightInfo(fullContent, bookName, i, j, k);
            highlightList.add(h);
          }
        }
      }
    }
    return Scaffold(
        appBar: AppBar(title: Text('밑줄 목록')),
        body: ListView.builder(
            itemCount: highlightList.length,
            itemBuilder: (context, i) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: ListTile(
                    title: Text(highlightList[i].fullContent,
                            style: TextStyle(
                                fontSize: 20,
                                color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
                            )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  name: highlightList[i].bookName,
                                  book: highlightList[i].book,
                                  chapter: highlightList[i].chapter,
                                  verse: highlightList[i].verse)));
                    },
                  ));
            }));
  }
}
