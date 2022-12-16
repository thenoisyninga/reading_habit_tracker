import 'package:flutter/material.dart';

class BookFinishedCongrats extends StatelessWidget {
  const BookFinishedCongrats({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Congratulations! You just finished '$bookName'",
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}