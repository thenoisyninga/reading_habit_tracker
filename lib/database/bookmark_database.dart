import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Bookmark_Database");

class BookmarksDatabase{
  
  List<List<dynamic>> bookmarksData = [];

  createDefaultData() {
    bookmarksData = [["The Subtle Art Of Not Giving A Fuck",'10','356'], ["Deep Work",'99','322']];
    updateData();
  }

  loadData() {
    if (_myBox.get('bookmarks_data_list') == null) {
      createDefaultData();
    } else {
      List<String> _combinedStringList = _myBox.get('bookmarks_data_list');
      bookmarksData = [];
      _combinedStringList.forEach((element) {
        bookmarksData.add(element.split(","));
      });
  }}

  updateData() {
    List<String> _combinedStringList = [];
    bookmarksData.forEach((element) {
      _combinedStringList.add(element.join(","));
    });
    _myBox.put('bookmarks_data_list', _combinedStringList);
  }

  addBookmark(String bookName, int pageNum, int totalPages) {
    bookmarksData.add([bookName, pageNum, totalPages]);
    updateData();
  }

  deleteBookmark(String bookName) {
    bookmarksData.remove(bookmarksData.firstWhere((element) => element[0] == bookName));
    updateData();
  }

  updateBookmark(bookName, newPageNum) {
    int index = bookmarksData.indexOf(bookmarksData.firstWhere((element) => element[0] == bookName));
    bookmarksData[index] = [bookmarksData[index][0], newPageNum, bookmarksData[index][2]];
    updateData();
  }
}
