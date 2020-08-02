import 'package:flutter/material.dart';
import 'package:keep_bible_app/theme/app_theme.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: TabBar(
          indicatorColor: AppTheme.lightMode.primaryColor,
          labelColor: AppTheme.lightMode.primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(
                child: Text('구약', style: TextStyle(fontSize: 22))),
            Tab(
                child: Text('신약', style: TextStyle(fontSize: 22))),
          ],
        ),);
  }
}