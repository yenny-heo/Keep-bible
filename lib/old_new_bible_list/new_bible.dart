import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/title.dart';
import '../detail_list.dart';

class NewBible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewBibleList(
        bibles: List.generate(newB.length, (i) => (newB[i]))
    );
  }
}

class NewBibleList extends StatelessWidget {
  final List<String> bibles;
  const NewBibleList({Key key, this.bibles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          separatorBuilder: (context, i) => Divider(
            color: Colors.grey,
          ),
          itemCount: bibles.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Center(child: Text(bibles[i], style: TextStyle(fontSize: 25))),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailScreen(name: newB[i], book: i + 39)
                ));
              },
            );
          }),
    );
  }

}