import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/config.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/pages/settings.dart';
import 'package:reading_habbit_and_page_tracker/utils/confetti.dart';
import 'package:reading_habbit_and_page_tracker/utils/dialogues/add_bookmark.dart';
import 'package:reading_habbit_and_page_tracker/widgets/book_tile.dart';
import 'package:reading_habbit_and_page_tracker/widgets/no_books_added_banner.dart';
import 'package:reading_habbit_and_page_tracker/widgets/reading_habbit_heatmap.dart';

import '../utils/dialogues/book_finised_congrats.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ConfettiController _confettiController;

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

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    db.loadData();
    // Bookmarks Data from DB
    List<dynamic> bookmarksData = db.bookmarksData.reversed.toList();

    // Book Cards from Bookmarks Data - If null then return note
    List<Widget> cardsList = bookmarksData.isEmpty
        ? [
            const SizedBox(
              height: 120,
            ),
            const Center(
              child: NoBookAddedBanner(),
            )
          ]
        : bookmarksData
            .map((book) => BookTile(
                  bookName: book[0],
                  pageNum: int.parse(book[1]),
                  totalPages: int.parse(book[2]),
                  onChangedPageCallback: onChangedPage,
                  onDeleteCallback: onDelete,
                  onCompletedBookCallback: onCompletedBook,
                ))
            .toList();

    // Heatmap Calendar
    Widget readingHeatmapCalendar =
        ReadingHabbitHeatmapCalendar(datasets: db.getReadFrequencyData());

    // HeatmapCalendar + Book Cards
    List<Widget> listViewItems = List.from(db.getShowCalendarPref()
        ? [
            readingHeatmapCalendar,
            const SizedBox(
              height: 20,
            )
          ]
        : [])
      ..addAll(cardsList);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Image(
              image: AssetImage(currentTheme.isDark()
                  ? 'assets/appbar/appbar_title_black.png'
                  : 'assets/appbar/appbar_title_white.png'),
              height: 35,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SettingsPage(
                                  databaseReference: db,
                                  setShowCalendarPrefCallback:
                                      setShowCalendarPref,
                                  getShowCalendarPrefCallback:
                                      getShowCalendarPref,
                                ))));
                  },
                  icon: const Icon(
                    Icons.settings,
                  )),
            ],
          ),
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/backdrop/backdrop.png'),
                      fit: BoxFit.cover)),

              // If calender hidden && no book cards, then no books message in center, else list view
              child: !db.getShowCalendarPref() && bookmarksData.isEmpty
                  ? const Center(
                      child: NoBookAddedBanner(),
                    )
                  : ListView(children: listViewItems)),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AddBookMarkDialogue(
                        addNewBookMarkCallback: addNewBookMark,
                        bookmarkAlreadyExistsCheckCallback:
                            bookmarkAlreadyExists,
                      ));
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        CelebrationConfetti(controller: _confettiController),
      ],
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
    return db.getShowCalendarPref();
  }

  void setShowCalendarPref(bool newValue) {
    setState(() {
      db.setShowCalendarPref(newValue);
    });
  }

  void onCompletedBook(String bookName) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Congrats on finishing the book <3")));
    showDialog(context: context, builder: (__) => BookFinishedCongrats(bookName: bookName));
    _confettiController.play();
  }
}
