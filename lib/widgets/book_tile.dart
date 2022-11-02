import 'package:flutter/material.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';

class BookTile extends StatefulWidget {
  BookTile({super.key, required this.bookName, required this.pageNum, required this.totalPages, required this.onChangedPageCallback, required this.onDeleteCallback, });
  final String bookName;
  late int pageNum;
  final int totalPages;
  final Function(String, int) onChangedPageCallback;
  final Function(String) onDeleteCallback;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  final TextEditingController _controller = TextEditingController();
  
  String get bookName => widget.bookName;
  
  set pageNum(int pageNum) {widget.pageNum = pageNum;}

  @override
  void initState() {
    super.initState();
    _controller.text = widget.pageNum.toString();

    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 130,
        width: MediaQuery.of(context).size.width * 0.9,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.bookName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  splashRadius: 20,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: ((_) => AlertDialog(
                        backgroundColor: Colors.grey[850],
                        title: Text(
                          "Are you sure you want to delete the bookmark for the book ${widget.bookName}?",
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        actions: [
                            TextButton(
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.red
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
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(_);
                              },
                            )
                          ],
                      )
                    ));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.pageNum.toString(),
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "/${widget.totalPages.toString()}",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    print("Edit button Pressed");
                    _controller.text = widget.pageNum.toString();
                    showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: Text(
                        "Update Bookmark",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            TextButton(
                              child: Text("Update"),
                              onPressed: () {
                                widget.onChangedPageCallback(bookName, int.parse(_controller.text));
                                Navigator.pop(_);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                    );
                  },
                  splashRadius: 20,
                  icon: Icon(Icons.edit),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
