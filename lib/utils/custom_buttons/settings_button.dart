import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {super.key, required this.title, required this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        height: 63,
        width: 200,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
