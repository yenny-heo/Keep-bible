import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/korhkjv.dart';
import 'package:keep_bible_app/data/title.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  var items = List<String>();
  String query = "";

  void filterSearchResults(String query) {
    var SearchList = korhkjv;
    String title;
    if (query.isNotEmpty) {
      List<String> listData = List<String>();
      for (int i = 0; i < SearchList.length; i++) {
        for (int j = 0; j < SearchList[i].length; j++) {
          for (int k = 0; k < SearchList[i][j].length; k++) {
            if (SearchList[i][j][k].contains(query)) {
              if (i <= 38)
                title = korOldB[i];
              else
                title = korNewB[i-39];
              String tmp = title + (j+1).toString() + ":" + (k+1).toString() + " "+SearchList[i][j][k];
              listData.add(tmp);
            }
          }
        }
      }
      setState(() {
        items.clear();
        items.addAll(listData);
      });
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
                                '${items[idx]}',
                            style: TextStyle(
                              fontSize: 20
                            ),)
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
