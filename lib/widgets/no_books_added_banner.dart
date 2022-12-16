import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoBookAddedBanner extends StatelessWidget {
  const NoBookAddedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    print(Colors.grey[300].toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/custom_icons/no-content_light_grey.png'),
          height: 75,
        ),
        const SizedBox(height: 15),
        Text(
          "No books added yet.\nGet a book bro :p",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
