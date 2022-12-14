import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinkButton extends StatelessWidget {
  const SocialMediaLinkButton({super.key, required this.iconData, required this.link});
  final IconData iconData;
  final String link;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          print(link);
          final Uri url = Uri.parse(link);
          launchUrl(url, mode: LaunchMode.externalApplication);
        },
        icon: Icon(
          iconData,
          color: Colors.white,
          size: 30,
        ));
  }
}
