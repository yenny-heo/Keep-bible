import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/bible.dart';
import 'data/title.dart';

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
              style: TextStyle(color: Colors.black, fontSize: 15),
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
        verses: List.generate(data[widget.book][chapter].length, (i) => (data[widget.book][chapter][i]))
      )
    );
  }
}

class VerseList extends StatefulWidget {
  final List<String> verses;

  const VerseList({Key key, this.verses}) : super(key: key);
  @override
  _VerseListState createState() => _VerseListState();
}

class _VerseListState extends State<VerseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          separatorBuilder: (context, i) => Divider(
            color: Colors.grey,
          ),
          itemCount: widget.verses.length,
          itemBuilder: (context, i) {
            String verse = widget.verses[i];
            int n = i + 1;
            return ListTile(
              title: Text('$n: $verse')
            );
          }),
    );
  }

}
