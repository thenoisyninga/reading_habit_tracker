import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Credits",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 30),
      ),
      content: SizedBox(
        height: 300,
        child: Column(children: [
          CircleAvatar(
            child: Icon(Icons.face),
            radius: 40,
          ),
          SizedBox(height: 30),
          Text(
            "Hi there! This app is developed by me, Sarim Ahmed. Click the icons below if you want to check out more of my creations, or if you just want to get know me better :D",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[200]),
          ),
          SizedBox(height: 30),
          IconButton(
              onPressed: () {
                final Uri url = Uri.parse("https://github.com");
                launchUrl(url, mode: LaunchMode.externalApplication);
              },
              icon: Icon(
                FontAwesomeIcons.github,
                color: Colors.white,
                size: 30,
              ))
        ]),
      ),
    );
  }
}
