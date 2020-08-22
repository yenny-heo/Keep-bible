List<VerseHistory> verseHistory = [];

class VerseHistory{
  String bookName;
  int book;
  int chapter;
  int idx;
  VerseHistory(bookName, book, chapter, idx) {
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
    this.idx = idx;
  }
}