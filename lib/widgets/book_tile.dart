import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reading_habbit_and_page_tracker/config.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';

import '../utils/dialogues/book_finished_congrats.dart';

class BookTile extends StatefulWidget {
  BookTile({
    super.key,
    required this.bookName,
    required this.pageNum,
    required this.totalPages,
    required this.onChangedPageCallback,
    required this.onDeleteCallback,
    required this.onCompletedBookCallback,
  });
  final String bookName;
  late int pageNum;
  final int totalPages;
  final Function(String, int) onChangedPageCallback;
  final Function(String) onDeleteCallback;
  final Function(String) onCompletedBookCallback;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  final TextEditingController _controller = TextEditingController();

  String get bookName => widget.bookName;

  set pageNum(int pageNum) {
    widget.pageNum = pageNum;
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.pageNum.toString();
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.pageNum == widget.totalPages;
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 23, 23, 11.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (isCompleted)
              ? Theme.of(context).colorScheme.primary.withAlpha(100)
              : currentTheme.isDark()
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withAlpha(230),
        ),
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                child: AutoSizeText(
                  widget.bookName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: currentTheme.isDark()
                        ? Colors.grey[900]
                        : Colors.grey[300],
                    fontSize: 33,
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  iconSize: 30,
                  splashRadius: 20,
                  color: currentTheme.isDark()
                      ? Colors.grey[900]
                      : Colors.grey[300],
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((_) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: Text(
                                "Are you sure you want to delete the bookmark for the book '${widget.bookName}'?",
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                        // color: Colors.red
                                        ),
                                  ),
                                  onPressed: () {
                                    widget.onDeleteCallback(bookName);
                                    Navigator.pop(_);
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(_);
                                  },
                                )
                              ],
                            )));
                  },
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.pageNum.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            color: currentTheme.isDark()
                                ? Colors.grey[900]
                                : Colors.grey[300],
                          ),
                        ),
                        Text(
                          "/${widget.totalPages.toString()}",
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTheme.isDark()
                                ? Colors.grey[900]
                                : Colors.grey[300],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width * 0.2,
                        lineHeight: 5,
                        percent: widget.pageNum / widget.totalPages,
                        backgroundColor: currentTheme.isDark()
                            ? Colors.grey[900]
                            : Colors.grey[300],
                        progressColor: (isCompleted)
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(100)
                            : currentTheme.isDark()
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(210)
                                : Theme.of(context).colorScheme.primary,
                        barRadius: Radius.circular(90),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _controller.text = widget.pageNum.toString();
                    showDialog(
                        context: context,
                        builder: (_) {
                          String? errorPage;
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: Text(
                                "Update Bookmark",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 5),
                                    TextField(
                                      controller: _controller,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        errorText: errorPage,
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 3)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        )),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        )),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      child: const Text("Update"),
                                      onPressed: () {
                                        errorPage = null;
                                        var isNumCheck =
                                            num.tryParse(_controller.text);
                                        if (isNumCheck != null) {
                                          if (int.parse(_controller.text) <=
                                              widget.totalPages) {
                                            if (int.parse(_controller.text) <
                                                0) {
                                              setState(() {
                                                errorPage =
                                                    "You entered a negative number";
                                              });
                                            } else {
                                              setState(() {
                                                errorPage = null;
                                                if (int.parse(
                                                        _controller.text) ==
                                                    widget.totalPages) {
                                                  widget.onChangedPageCallback(
                                                      bookName,
                                                      int.parse(
                                                          _controller.text));
                                                  Navigator.pop(_);
                                                  widget
                                                      .onCompletedBookCallback(
                                                          widget.bookName);
                                                } else {
                                                  widget.onChangedPageCallback(
                                                    bookName,
                                                    int.parse(_controller.text),
                                                  );
                                                  Navigator.pop(_);
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              errorPage =
                                                  "Page number greater than total pages.";
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            errorPage = "This is not a number.";
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  splashRadius: 20,
                  icon: Icon(Icons.edit),
                  iconSize: 30,
                  color: currentTheme.isDark()
                      ? Colors.grey[900]
                      : Colors.grey[300],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
