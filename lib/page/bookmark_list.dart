import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/bookmarks.dart';
import 'package:keep_bible_app/data/title.dart';

import 'verse_list.dart';

List<BookmarkInfo> bookmarkList = List<BookmarkInfo>();

class BookmarkInfo {
  String fullName;
  String bookName;
  int book;
  int chapter;

  BookmarkInfo(fullName, bookName, book, chapter) {
    this.fullName = fullName;
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
  }
}

class BookmarkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bookmarkList = [];
    for (int i = 0; i < bookMarks.length; i++) {
      for (int j = 0; j < bookMarks[i].length; j++) {
        if (bookMarks[i][j][0]) {
          String fullName, bookName;
          int book = i, chapter = j;
          if (i <= 38) {
            //구약
            fullName = korOldB[i] + " " + (j + 1).toString() + "장";
            bookName = korOldB[i];
          } else {
            fullName = korNewB[i - 39] + " " + (j + 1).toString() + "장";
            bookName = korNewB[i - 39];
          }
          BookmarkInfo b = BookmarkInfo(fullName, bookName, book, chapter);
          bookmarkList.add(b);
        }
      }
    }
    return Scaffold(
        appBar: AppBar(title: Text('책갈피 목록')),
        body: ListView.builder(
            itemCount: bookmarkList.length,
            itemBuilder: (context, i) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: ListTile(
                    title: Center(
                        child: Text(bookmarkList[i].fullName,
                            style: TextStyle(fontSize: 25))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  name: bookmarkList[i].bookName,
                                  book: bookmarkList[i].book,
                                  chapter: bookmarkList[i].chapter)));
                    },
                  ));
            }));
  }
}
