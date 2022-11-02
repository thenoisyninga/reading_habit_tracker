import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_habbit_and_page_tracker/pages/main_page.dart';

void main() async {

  await Hive.initFlutter();

  await Hive.openBox("Bookmark_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Track',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.grey[900]
      ),
      initialRoute: '/home',
      routes: {
        '/home':(context) => MainPage()
      },
    );
  }
}
