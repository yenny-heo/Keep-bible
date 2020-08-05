import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/data/title.dart';
import 'package:keep_bible_app/page/verse_page.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:keep_bible_app/toast/toast.dart';
import 'package:provider/provider.dart';

String query = "";
int option = 0;
int totalSearch = 0;
bool isDark = false;

class SearchInfo {
  String content;
  String bookName;
  int book;
  int chapter;
  int verse;

  SearchInfo(content, bookName, book, chapter, verse) {
    this.content = content;
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
    this.verse = verse;
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  var items = List<SearchInfo>();

  void filterSearchResults(String query) {
    var searchList = korhkjv;
    if (query.isNotEmpty) {
      List<SearchInfo> listData = List<SearchInfo>();
      for (int i = 0; i < searchList.length; i++) {
        for (int j = 0; j < searchList[i].length; j++) {
          for (int k = 0; k < searchList[i][j].length; k++) {
            if(option == 0 || (option == 1 && i <= 38) || (option == 2 && i > 38) ||
                (option >= 3 && i == option - 3)){//영역 필터링
              String content, bookName;
              int book = i,
                  chapter = j;
              if (searchList[i][j][k].contains(query)) {
                int verse = k;
                if (i <= 38)
                  bookName = korOldShortB[i];
                else
                  bookName = korNewShortB[i - 39];
                content = bookName + (j + 1).toString() + ":" + (k + 1).toString() + " " + searchList[i][j][k];
                SearchInfo s = SearchInfo(content, bookName, book, chapter, verse);
                totalSearch++;
                listData.add(s);
              }
            }
          }
        }
      }
      setState(() {
        items.clear();
        items.addAll(listData);
        if(listData.isNotEmpty) toast("총 $totalSearch개의 일치하는 절을 찾았습니다");
        FocusScope.of(context).unfocus();
        totalSearch = 0;
      });
      if (listData.isEmpty) {
        toast("일치하는 검색어가 없습니다");
      }
    }
    else {
      setState(() {
        items.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
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
                          style: TextStyle(
                              color: isDark
                                  ? AppTheme.darkMode.accentColor
                                  : AppTheme.lightMode.accentColor
                          ),
                          onChanged: (val) {
                            query = val;
                          },
                          decoration: InputDecoration(
                            labelText: "검색",
                            hintText: "키워드로 검색하세요",
                            labelStyle: TextStyle(
                                color: Colors.grey
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: AppTheme.lightMode.primaryColor,
                                    width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2)),
                          ),
                        )),
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey,
                      onPressed: () => filterSearchResults(query),
                    )
                  ],
                ),
              ),
              DropdownButton<int>(
                isExpanded: true,
                value: option,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30,
                style: TextStyle(color: isDark? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor, fontSize: 18),
                onChanged: (int newOption){
                  setState(() {
                    option = newOption;
                    filterSearchResults(query);
                  });
                },
                items: searchOption.map((val){
                  return DropdownMenuItem(
                    value: searchOption.indexOf(val),
                    child:Center(child: Text(val))
                  );
                }).toList()
              ),
              Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, idx) {
                        return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1))
                            ),
                            child:
                            ListTile(
                              title: RichText(
                                  text: searchMatch(
                                      items[idx].content, isDark)
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(
                                                name: items[idx].bookName,
                                                book: items[idx].book,
                                                chapter: items[idx].chapter,
                                                verse: items[idx].verse)));
                              },
                            )
                        );
                      },
                    ),
                  )
              )
            ],
          ),
        ));
  }
}

TextStyle negRes(isDark) {
  return TextStyle(color: isDark ? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor,
      fontSize: 18,
      backgroundColor: isDark
          ? AppTheme.darkMode.scaffoldBackgroundColor
          : AppTheme.lightMode.scaffoldBackgroundColor);
}

TextStyle posRes(isDark) {
  return TextStyle(color: Colors.white, fontSize: 18,
      backgroundColor: Color(0xff546fee));
}

TextSpan searchMatch(String match, bool isDark) {
  if (query == "" || query == null) {
    return null;
  }
  if (match.contains(query)) {
    if (match.substring(0, query.length) == query) {
      return TextSpan(
          style: posRes(isDark),
          text: match.substring(0, query.length),
          children: [
            searchMatch(match.substring(query.length), isDark)
          ]
      );
    }
    else {
      return TextSpan(
          style: negRes(isDark),
          text: match.substring(0, match.indexOf(query)),
          children: [
            searchMatch(match.substring(match.indexOf(query)), isDark)
          ]
      );
    }
  }
  else {
    return TextSpan(
        style: negRes(isDark),
        text: match
    );
  }
}