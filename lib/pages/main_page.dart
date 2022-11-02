import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/widgets/book_tile.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var _myBox = Hive.box("Bookmark_Database");
  BookmarksDatabase db = BookmarksDatabase();

  @override
  void initState() {

    if (_myBox.get("bookmarks_data_list") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    db.loadData();
    List<dynamic> bookmarks = db.bookmarksData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "M A I N   P A G E",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: bookmarks.map((book) => BookTile(
            bookName: book[0],
            pageNum: int.parse(book[1]),
            totalPages: int.parse(book[2]),
            onChangedPageCallback: onChangedPage,
            onDeleteCallback: onDelete,
          )).toList()
        ),
      )
    );
  }

  void onDelete(String bookName) {
    setState(() {
      db.deleteBookmark(bookName);
      db.loadData();
    });
  }

  void onChangedPage(String bookName, int newPageNum) {
    setState(() {
      db.updateBookmark(bookName, newPageNum);
      db.loadData();
    });
  }
}