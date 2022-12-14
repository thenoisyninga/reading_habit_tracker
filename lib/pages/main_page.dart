import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/pages/settings.dart';
import 'package:reading_habbit_and_page_tracker/utils/dialogues/add_bookmark.dart';
import 'package:reading_habbit_and_page_tracker/widgets/book_tile.dart';
import 'package:reading_habbit_and_page_tracker/widgets/reading_habbit_heatmap.dart';

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
    // Bookmarks Data from DB
    List<dynamic> bookmarksData = db.bookmarksData.reversed.toList();

    // Book Cards from Bookmarks Data - If null then return note
    List<Widget> cardsList = bookmarksData.isEmpty
        ? [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Text(
                "No books added yet.\nGet a book bro :p",
                textAlign: TextAlign.center,
                style: TextStyle(
                    // color: Colors.grey[200],
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.9)),
              ),
            )
          ]
        : bookmarksData
            .map((book) => BookTile(
                  bookName: book[0],
                  pageNum: int.parse(book[1]),
                  totalPages: int.parse(book[2]),
                  onChangedPageCallback: onChangedPage,
                  onDeleteCallback: onDelete,
                ))
            .toList();

    // Heatmap Calendar
    Widget readingHeatmapCalendar =
        ReadingHabbitHeatmapCalendar(datasets: db.getReadFrequencyData());

    // HeatmapCalendar + Book Cards
    List<Widget> listViewItems = List.from(db.getShowCalendarPref()
        ? [
            readingHeatmapCalendar,
            SizedBox(
              height: 20,
            )
          ]
        : [])
      ..addAll(cardsList);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reading Habbit Tracker",
          style: GoogleFonts.seaweedScript(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/settings', arguments: {
                //   'databaseReference': db,
                //   'setShowCalendarPrefCallback': setShowCalendarPref,
                //   'getShowCalendarPrefCallback': getShowCalendarPref
                // });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SettingsPage(
                              databaseReference: db,
                              setShowCalendarPrefCallback: setShowCalendarPref,
                              getShowCalendarPrefCallback: getShowCalendarPref,
                            ))));
              },
              icon: Icon(
                Icons.settings,
              ))
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backdrop/backdrop.png'),
                  fit: BoxFit.cover)),

          // If calender hidden && no book cards, then no books message in center, else list view
          child: !db.getShowCalendarPref() && bookmarksData.isEmpty
              ? Center(
                  child: Text(
                    "No books added yet.\nGet a book bro :p",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Colors.grey[200],
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.9)),
                  ),
                )
              : ListView(children: listViewItems)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AddBookMarkDialogue(
                    addNewBookMarkCallback: addNewBookMark,
                    bookmarkAlreadyExistsCheckCallback: bookmarkAlreadyExists,
                  ));
        },
        child: Icon(
          Icons.add,
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
      db.addBookmark(bookName, 0, totalPages);
    });
  }

  bool bookmarkAlreadyExists(String bookName) {
    return db.bookmarkAlreadyExistsCheck(bookName);
  }

  bool getShowCalendarPref() {
    print("Get Callback Called");
    return db.getShowCalendarPref();
  }

  void setShowCalendarPref(bool newValue) {
    setState(() {
      print("Set Callback Called");
      db.setShowCalendarPref(newValue);
    });
  }
}
