import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_bible_app/data/korhrv.dart';
import 'package:keep_bible_app/local_storage/bookmarks.dart';
import 'package:keep_bible_app/data/engkjv.dart';
import 'package:keep_bible_app/local_storage/highlighted_verses.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:keep_bible_app/toast/toast.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

ItemScrollController _scrollController;

class DetailScreen extends StatefulWidget {
  final String name;
  final int book;
  int chapter;
  int verse;

  DetailScreen({Key key, this.name, this.book, this.chapter, this.verse}) : super(key: key);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  IconData bookMarkIcon;
  int currentPage;
  @override
  void initState() {
    // TODO: implement initState
    currentPage = widget.chapter;
    _scrollController = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List bible = [];
    int bibleNum = 0;
    if (selectedBible[0] == true) {
      bible.add(korhkjv);
      bibleNum++;
    }
    if (selectedBible[1] == true) {
      bible.add(engkjv);
      bibleNum++;
    }
    if (selectedBible[2] == true) {
      bible.add(korhrv);
      bibleNum++;
    }

    final chapterList = Iterable<int>.generate(bible[0][widget.book].length).toList();

    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    bookMarks[widget.book][currentPage][0] ? bookMarkIcon = Icons.bookmark : bookMarkIcon = Icons.bookmark_border;

    Future<File> _setBookmark() {
      bool flag = bookMarks[widget.book][currentPage][0];
      setState(() {
        bookMarks[widget.book][currentPage][0] = !flag;
        flag ? bookMarkIcon = Icons.bookmark: bookMarkIcon = Icons.bookmark_border;
      });
      if(!flag)
        toast("책갈피를 추가했습니다.");
      else
        toast("책갈피가 삭제되었습니다.");

      return writeBookmark(bookMarks);
    }

    void _showChapterDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: 300,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: chapterList.map((val) {
                    return MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentPage = val;
                            _scrollController.jumpTo(index: 0);
                            bookMarks[widget.book][currentPage][0]
                                ? bookMarkIcon = Icons.bookmark
                                : bookMarkIcon = Icons.bookmark_border;
                          });
                          Navigator.pop(context);
                        },
                        color: isDark? AppTheme.darkMode.focusColor: AppTheme.lightMode.focusColor,
                        minWidth: 0,
                        height: 0,
                        padding: EdgeInsets.zero,
                        child: Text('${val + 1}', style: TextStyle(fontSize: 20, color: Colors.white),)
                    );
                  }).toList(),
                ),
              )
            );
          });
    }

    void _showVerseDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          final verseList = Iterable<int>.generate(bible[0][widget.book][currentPage].length).toList();
          return AlertDialog(
              content: Container(
                width: 300,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: verseList.map((val) {
                    return MaterialButton(
                        onPressed: () {
                          _scrollController.jumpTo(index: val);
                          Navigator.pop(context);
                        },
                        color: isDark? AppTheme.darkMode.focusColor: AppTheme.lightMode.focusColor,
                        minWidth: 0,
                        height: 0,
                        padding: EdgeInsets.zero,
                        child: Text('${val + 1}', style: TextStyle(fontSize: 20, color: Colors.white),)
                    );
                  }).toList(),
                ),
              )
          );
        }
      );
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
                  Text('${currentPage+1} 장',
                    style: TextStyle(fontSize: 18, color: Colors.white),),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                ],
              ),
                onPressed: () => _showChapterDialog(),
              ),
            MaterialButton(
              minWidth: 50,
              height: 10,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              clipBehavior: Clip.antiAlias,
              child:Row(
                children: <Widget>[
                  Text('절',
                    style: TextStyle(fontSize: 18, color: Colors.white),),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                ],
              ),
              onPressed: () => _showVerseDialog(),
            ),
            ToggleButtons(
              children: <Widget>[Icon(bookMarkIcon)],
              onPressed: (int i) => _setBookmark(),
              isSelected: bookMarks[widget.book][currentPage].cast<bool>(),
              color: Colors.white,
              fillColor: isDark
                ? AppTheme.darkMode.primaryColor
                : AppTheme.lightMode.primaryColor,
              selectedColor: Colors.white,
              borderColor: isDark
                  ? AppTheme.darkMode.primaryColor
                  : AppTheme.lightMode.primaryColor,
              selectedBorderColor: isDark
                  ? AppTheme.darkMode.primaryColor
                  : AppTheme.lightMode.primaryColor,
            )
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if(details.velocity.pixelsPerSecond.dx>0 && currentPage > 0){
              setState(() {
                currentPage -= 1;
                _scrollController.jumpTo(index: 0);
              });
            }
            else if(details.velocity.pixelsPerSecond.dx<0 && currentPage < bible[0][widget.book].length - 1){
              setState(() {
                currentPage += 1;
                _scrollController.jumpTo(index: 0);
              });
            }
          },
            child: VerseList(
                bible: bible,
                bookName: widget.name,
                book: widget.book,
                chapter: currentPage,
                verse: widget.verse,
                selected: List.generate(bible[0][widget.book][currentPage].length,
                        (i) => List.generate(bibleNum, (index) => false)))
        )
    );
  }
}

class VerseList extends StatefulWidget {
  final List bible;
  final String bookName;
  final int book;
  final int chapter;
  final int verse;
  final List selected;

  const VerseList({Key key, this.bible, this.bookName, this.book, this.chapter, this.verse, this.selected})
      : super(key: key);

  @override
  _VerseListState createState() => _VerseListState();
}

class _VerseListState extends State<VerseList> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    Color highlightColor = isDark ? Colors.white38 : Color(0xffeeca54);
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

    Future<File> _setHighlight(){
      for(int i=0; i<widget.selected.length; i++){
        for(int j=0; j<widget.selected[i].length; j++){
          if(widget.selected[i][j]){
            setState(() {
              highlights[widget.book][widget.chapter][i] = true;
              widget.selected[i][j] = false;
            });
          }
        }
      }
      Navigator.pop(context);
      return writeHighlight(highlights);
    }
    Future<File> _removeHighlight(){
      for(int i=0; i<widget.selected.length; i++){
        for(int j=0; j<widget.selected[i].length; j++){
          if(widget.selected[i][j]){
            setState(() {
              highlights[widget.book][widget.chapter][i] = false;
              widget.selected[i][j] = false;
            });
          }
        }
      }
      Navigator.pop(context);
      return writeHighlight(highlights);
    }
    void _copyVerses(){
      String items = "";
      for(int i=0; i<widget.selected.length; i++){
        for(int j=0; j<widget.selected[i].length; j++){
          if(widget.selected[i][j]){
            items = items
                + widget.bookName + (widget.chapter + 1).toString() + ":" + (i+1).toString() + " "
                +(widget.bible[j][widget.book][widget.chapter][i]) + "\n";
          }
        }
      }
      Clipboard.setData(ClipboardData(text: items));
      toast("클립보드에 복사되었습니다.");
      Navigator.pop(context);
    }
    void _showDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("선택 절",style: TextStyle(fontSize: 18, color: isDark ? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor)),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child:  Text("복사하기",style: TextStyle(fontSize: 20, color: isDark ? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor)),
                    ),
                    onTap: () => _copyVerses(),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child:  Text("밑줄긋기",style: TextStyle(fontSize: 20, color: isDark ? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor)),
                    ),
                    onTap: () => _setHighlight(),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child:  Text("밑줄 해제하기",style: TextStyle(fontSize: 20, color: isDark ? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor)),
                    ),
                    onTap: () => _removeHighlight(),
                  ),
                ],
              ),
            ),
          );
        }
      );
    }
    return ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            initialScrollIndex: widget.verse,
            itemCount: widget.bible[0][widget.book][widget.chapter].length,
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                        BorderSide(color: Colors.grey, width: 1))),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.bible.length,
                  itemBuilder: (context2, j) {
                    return Container(
                        decoration: BoxDecoration(
                            color: widget.selected[i][j]
                                ? mode.focusColor
                                : mode.scaffoldBackgroundColor,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.5))),
                        child: ListTile(
                          selected: widget.selected[i][j],
                          title: Text(
                            "${i+1}. ${widget.bible[j][widget.book][widget.chapter][i]}",
                            style: TextStyle(
                                fontSize: 22,
                                color: widget.selected[i][j]
                                    ? selectedColors[j]
                                    : unSelectedColors[j],
                                backgroundColor: highlights[widget.book][widget.chapter][i] ? highlightColor : null
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              widget.selected[i][j] = !widget.selected[i][j];
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              widget.selected[i][j] = true;
                            });
                            _showDialog();
                          },
                        )
                    );
                  })
              );
            });
  }
}
