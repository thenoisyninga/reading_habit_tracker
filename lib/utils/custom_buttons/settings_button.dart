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
        height: 50,
        width: 150,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
