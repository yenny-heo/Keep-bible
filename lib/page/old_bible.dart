import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/title.dart';
import 'verse_list.dart';

class OldBible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OldBibleList(bibles: List.generate(korOldB.length, (i) => (korOldB[i])));
  }
}

class OldBibleList extends StatelessWidget {
  final List<String> bibles;

  const OldBibleList({Key key, this.bibles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: bibles.length,
          itemBuilder: (context, i) {
            return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1))),
                child: ListTile(
                  title: Center(
                      child: Text(bibles[i], style: TextStyle(fontSize: 25))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(name: korOldB[i], book: i, chapter: 0)));
                  },
                ));
          }),
    );
  }
}
