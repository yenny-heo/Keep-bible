import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/bible.dart';

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
    final fixedList = Iterable<int>.generate(data[widget.book].length).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          actions: <Widget>[
            DropdownButton<int>(
                value: chapter,
                iconEnabledColor: Colors.white,
                style: TextStyle(color: Colors.black, fontSize: 20),
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (int i) {
                  setState(() {
                    chapter = i;
                  });
                },
                items: fixedList.map((i) {
                  int a = i + 1;
                  return DropdownMenuItem<int>(value: i, child: Text('$a 장'));
                }).toList())
          ],
        ),
        body: VerseList(
          verses: List.generate(data[widget.book][chapter].length,
              (i) => (data[widget.book][chapter][i])),
          selected:
              List.generate(data[widget.book][chapter].length, (i) => (false)),
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
            return Container(
                decoration: BoxDecoration(
                    color: widget.selected[i] ? Colors.blueGrey : Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                child: ListTile(
                  title: Text(
                    '$n: $verse',
                    style: TextStyle(fontSize: 22, color: widget.selected[i] ? Colors.white : Colors.black),
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
