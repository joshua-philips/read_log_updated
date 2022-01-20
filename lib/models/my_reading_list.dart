import 'package:flutter/material.dart';

/// List of already logged books in My Reading List
class MyReadingList extends ChangeNotifier {
  List<String> myReadingListTitles = [];
  List<String> myReadingListAuthors = [];

  MyReadingList({
    required this.myReadingListAuthors,
    required this.myReadingListTitles,
  });

  void addToReadingList(String title, String firstAuthor) {
    myReadingListTitles.add(title.toLowerCase());
    myReadingListAuthors.add(firstAuthor.toLowerCase());
  }

  void addNewToReadingList(String title, String firstAuthor) {
    myReadingListTitles.add(title.toLowerCase());
    myReadingListAuthors.add(firstAuthor.toLowerCase());

    notifyListeners();
  }

  void removeFromReadingList(String title, String firstAuthor) {
    while (myReadingListTitles.contains(title.toLowerCase()) &&
        myReadingListAuthors.contains(firstAuthor.toLowerCase())) {
      myReadingListTitles.remove(title.toLowerCase());
      myReadingListAuthors.remove(firstAuthor.toLowerCase());
    }

    notifyListeners();
  }

  bool isInReadingList(String title, String firstAuthor) {
    if (myReadingListTitles.contains(title.toLowerCase()) &&
        myReadingListAuthors.contains(firstAuthor.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }
}
