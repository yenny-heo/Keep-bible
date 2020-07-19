import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/data/title.dart';
import 'package:keep_bible_app/page/verse_page.dart';
import 'package:keep_bible_app/toast/toast.dart';

class SearchInfo {
  String content;
  String bookName;
  int book;
  int chapter;
  SearchInfo(content, bookName, book, chapter) {
    this.content = content;
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
  }
}
class SearchPage extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  var items = List<SearchInfo>();
  String query = "";

  void filterSearchResults(String query) {
    var SearchList = korhkjv;
    if (query.isNotEmpty) {
      List<SearchInfo> listData = List<SearchInfo>();
      for (int i = 0; i < SearchList.length; i++) {
        for (int j = 0; j < SearchList[i].length; j++) {
          for (int k = 0; k < SearchList[i][j].length; k++) {
            String content, bookName;
            int book = i, chapter = j;
            if (SearchList[i][j][k].contains(query)) {
              if (i <= 38)
                bookName = korOldB[i];
              else
                bookName = korNewB[i-39];
              content = bookName + (j+1).toString() + ":" + (k+1).toString() + " "+SearchList[i][j][k];
              SearchInfo s = SearchInfo(content, bookName, book, chapter);
              listData.add(s);
            }
          }
        }
      }
      setState(() {
        items.clear();
        items.addAll(listData);
      });
      if(listData.isEmpty){
        toast("일치하는 검색어가 없습니다");
      }
    }
    else{
      setState(() {
        items.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('검색')),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (val){
                          query = val;
                        },
                        decoration: InputDecoration(
                            labelText: "검색",
                            hintText: "키워드로 검색하세요",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => filterSearchResults(query),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, idx){
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Colors.grey, width: 1))
                      ),
                      child:
                      ListTile(
                        title: Text(
                          '${items[idx].content}',
                          style: TextStyle(
                              fontSize: 20
                          ),),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(
                                          name: items[idx].bookName,
                                          book: items[idx].book,
                                          chapter: items[idx].chapter)));
                        },
                      )
                    );
                  },
                )
              )
            ],
          ),
        ));
  }
}
