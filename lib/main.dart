import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/config.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/pages/main_page.dart';
import 'package:reading_habbit_and_page_tracker/pages/settings.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("Bookmark_Database");
  await Hive.openBox("Theme_Data");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Track',
      theme: ThemeData(
          primaryColor: currentTheme.getCurrentPrimarySwatch(),
          primarySwatch: currentTheme.getCurrentPrimarySwatch(),
          scaffoldBackgroundColor: Colors.grey[900],
          iconTheme: IconThemeData(color: Colors.grey[900]),
          buttonTheme: ButtonThemeData(
            splashColor: currentTheme.getCurrentPrimarySwatch().withAlpha(200),
          ),
          dialogBackgroundColor: Colors.grey[900]
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainPage(),
        '/settings': (context) => SettingsPage(
              databaseReference: BookmarksDatabase(),
              setShowCalendarPrefCallback: (bool) {},
              getShowCalendarPrefCallback: () {},
            ),
      },
    );
  }
}
