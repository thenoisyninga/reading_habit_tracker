import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Bookmark_Database");

class BookmarksDatabase{
  
  List<List<dynamic>> bookmarksData = [];

  createDefaultData() {
    bookmarksData = [["Shoe Dog",'10','356'], ["Deep Work",'99','322']];
    updateData();
  }

  loadData() {
    if (_myBox.get('bookmarks_data_list') == null) {
      createDefaultData();
    } else {
      List<String> combinedStringList = _myBox.get('bookmarks_data_list');
      bookmarksData = [];
      for (var element in combinedStringList) {
        bookmarksData.add(element.split(","));
      }
  }}

  updateData() {
    List<String> combinedStringList = [];
    for (var element in bookmarksData) {
      combinedStringList.add(element.join(","));
    }
    _myBox.put('bookmarks_data_list', combinedStringList);
  }

  addBookmark(String bookName, int pageNum, int totalPages) {
    bookmarksData.add([bookName, pageNum.toString(), totalPages.toString()]);
    updateData();
    loadData();
  }

  deleteBookmark(String bookName) {
    bookmarksData.remove(bookmarksData.firstWhere((element) => element[0] == bookName));
    updateData();
    loadData();
  }

  updateBookmark(bookName, newPageNum) {
    int index = bookmarksData.indexOf(bookmarksData.firstWhere((element) => element[0] == bookName));
    bookmarksData[index] = [bookmarksData[index][0], newPageNum, bookmarksData[index][2]];
    updateData();
    loadData();
  }

  bool bookmarkAlreadyExistsCheck(String bookName) {
    loadData();
    int index = 0;
    bool contains = false;
    while (index < bookmarksData.length) {
      if (bookmarksData[index][0] == bookName) {
        contains = true;
        break;
      }
      index++;
    }
    return contains;
  }
}
