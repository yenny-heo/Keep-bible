import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 50,
        child: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(
                child: Text('구약', style: TextStyle(fontSize: 22))),
            Tab(
                child: Text('신약', style: TextStyle(fontSize: 22))),
          ],
        ),),);
  }
}