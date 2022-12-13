import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Bookmark_Database");

class BookmarksDatabase {
  List<List<dynamic>> bookmarksData = [];
  Map<dynamic, dynamic> pagesReadDaily = {};
  createDefaultData() {
    bookmarksData = [];
    pagesReadDaily = {};
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

      if (_myBox.get('pages_daily_read_data') == null) {
        createDefaultData();
      } else {
        pagesReadDaily = _myBox.get('pages_daily_read_data');
      }
    }
  }

  updateData() {
    List<String> combinedStringList = [];
    for (var element in bookmarksData) {
      combinedStringList.add(element.join(","));
    }
    _myBox.put('bookmarks_data_list', combinedStringList);
    _myBox.put('pages_daily_read_data', pagesReadDaily);
  }

  addBookmark(String bookName, int pageNum, int totalPages) {
    bookmarksData.add([bookName, pageNum.toString(), totalPages.toString()]);
    updateData();
    loadData();
  }

  deleteBookmark(String bookName) {
    bookmarksData
        .remove(bookmarksData.firstWhere((element) => element[0] == bookName));
    updateData();
    loadData();
  }

  updateBookmark(bookName, newPageNum) {
    //Add new pages to today's progress
    updateTotalPagesReadToday(bookName, newPageNum);

    // Set the new page num
    int index = bookmarksData
        .indexOf(bookmarksData.firstWhere((element) => element[0] == bookName));
    bookmarksData[index] = [
      bookmarksData[index][0],
      newPageNum,
      bookmarksData[index][2]
    ];

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

  void updateTotalPagesReadToday(bookName, newPageNum) {
    int index = bookmarksData
        .indexOf(bookmarksData.firstWhere((element) => element[0] == bookName));
    
    int oldPageNum = bookmarksData[index][1];
    int deltaPagesRead = newPageNum - oldPageNum;
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int newTotalPagesRead = pagesReadDaily[today] + deltaPagesRead;
    pagesReadDaily[today] = newTotalPagesRead < 0 ? 0 : newTotalPagesRead;
    updateData();
    loadData();
  }
}
