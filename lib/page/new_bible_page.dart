import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/title.dart';
import 'package:keep_bible_app/local_storage/verse_history.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'verse_page.dart';

class NewBible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewBibleList(bibles: List.generate(korNewB.length, (i) => (korNewB[i])));
  }
}

class NewBibleList extends StatelessWidget {
  final List<String> bibles;

  const NewBibleList({Key? key, required this.bibles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =
    Provider.of<AppStateNotifier>(context, listen: false).getModeState();
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
                      child: Text(bibles[i],
                          style: TextStyle(
                              fontSize: 25,
                              color: isDark
                                  ? AppTheme.darkMode.hintColor
                                  : AppTheme.lightMode.hintColor))),
                  onTap: () {
                    var len = verseHistory.length;
                    verseHistory.add(VerseHistory(korNewShortB[i], i + 39, 0, len));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(name: korNewShortB[i], book: i + 39, chapter: 0, verse: 0, idx:len)));
                  },
                ));
          }),
    );
  }
}
