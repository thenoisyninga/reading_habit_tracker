import 'package:flutter/material.dart';

class AddBookMarkDialogue extends StatefulWidget {
  const AddBookMarkDialogue(
      {super.key,
      required this.addNewBookMarkCallback,
      required this.bookmarkAlreadyExistsCheckCallback});

  final Function(String bookName, int totalPages) addNewBookMarkCallback;
  final Function(String bookName) bookmarkAlreadyExistsCheckCallback;

  @override
  State<AddBookMarkDialogue> createState() => _AddBookMarkDialogueState();
}

class _AddBookMarkDialogueState extends State<AddBookMarkDialogue> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _totalPagesController = TextEditingController();
  String? bookNameError;
  String? totalPagesError;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        "Add New\nBookmark",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Theme.of(context).colorScheme.primary),
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // BookName Input
            TextField(
              controller: _bookNameController,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Book Name',
                errorText: bookNameError,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                )),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            // Total Pages Input
            TextField(
              controller: _totalPagesController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: totalPagesError,
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Total Pages',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                )),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            // Add Button
            ElevatedButton(
              child: Text("Add"),
              onPressed: () {

                // Verify Inputs
                var totalPagesCheck = num.tryParse(_totalPagesController.text);
                bookNameError = null;
                totalPagesError = null;

                if (!widget.bookmarkAlreadyExistsCheckCallback(
                        _bookNameController.text) &&
                    totalPagesCheck != null) {
                  widget.addNewBookMarkCallback(
                    _bookNameController.text,
                    int.parse(_totalPagesController.text),
                  );
                  Navigator.pop(context);
                } else {
                  if (widget.bookmarkAlreadyExistsCheckCallback(
                      _bookNameController.text)) {
                    setState(() {
                      bookNameError = "This book already exists.";
                    });
                  }

                  if (totalPagesCheck == null) {
                    setState(() {
                      totalPagesError = "This isnt a number.";
                    });
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
