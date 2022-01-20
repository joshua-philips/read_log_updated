import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Save and update the grid settings of Reading List page and
/// My Books page using ChangeNotifier and SharedPreferences
class GridSettings extends ChangeNotifier {
  final String myBooksKey = 'myBooksGrid';
  final String readingListKey = 'readingListGrid';
  late bool myBooksGrid;
  late bool readingListGrid;
  late SharedPreferences prefs;

  GridSettings() {
    myBooksGrid = false;
    readingListGrid = false;
    loadFromPrefs();
  }

  Future<void> initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  void loadFromPrefs() async {
    await initPrefs();
    myBooksGrid = prefs.getBool(myBooksKey) ?? true;
    readingListGrid = prefs.getBool(readingListKey) ?? true;
    notifyListeners();
  }

  void saveToPrefs() async {
    await initPrefs();
    prefs.setBool(myBooksKey, myBooksGrid);
    prefs.setBool(readingListKey, readingListGrid);
  }

  void toggleMyBooksGrid() {
    myBooksGrid = !myBooksGrid;
    saveToPrefs();
    notifyListeners();
  }

  void toggleReadingListGrid() {
    readingListGrid = !readingListGrid;
    saveToPrefs();
    notifyListeners();
  }
}
