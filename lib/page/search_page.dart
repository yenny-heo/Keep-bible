import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchState createState() => _SearchState();

}


class _SearchState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('검색')),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "검색",
                    hintText: "키워드로 검색하세요",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}