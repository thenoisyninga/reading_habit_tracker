import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/widgets/add_bookmark.dart';
import 'package:reading_habbit_and_page_tracker/widgets/book_tile.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _myBox = Hive.box("Bookmark_Database");
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
        title: Text(
          "B O O K M A R K S",
          style: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).scaffoldBackgroundColor,  
            )
          )
        ],
      ),


      body: bookmarks.isNotEmpty ? Padding(
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


      ) : const Center(
        child: Text(
          "Get a book bro.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 103, 103, 103)
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddBookMarkDialogue(
              addNewBookMarkCallback: addNewBookMark,
              bookmarkAlreadyExistsCheckCallback: bookmarkAlreadyExists,
            )
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }



  void onDelete(String bookName) {
    setState(() {
      db.deleteBookmark(bookName);
    });
  }

  void onChangedPage(String bookName, int newPageNum) {
    setState(() {
      db.updateBookmark(bookName, newPageNum);
      db.loadData();
    });
  }

  void addNewBookMark(String bookName, int totalPages) {
    setState(() {
      db.addBookmark(bookName, 1, totalPages);
    });
  }

  bool bookmarkAlreadyExists(String bookName) {
    return db.bookmarkAlreadyExistsCheck(bookName);
  }
}