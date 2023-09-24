List<VerseHistory> verseHistory = [];

class VerseHistory{
  late String bookName;
  late int book;
  late int chapter;
  late int idx;
  VerseHistory(bookName, book, chapter, idx) {
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
    this.idx = idx;
  }
}