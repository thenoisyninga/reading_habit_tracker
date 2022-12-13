import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:reading_habbit_and_page_tracker/config.dart';
import 'package:reading_habbit_and_page_tracker/dialogues/credits.dart';

import '../widgets/settings_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'S E T T I N G S',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/backdrop/backdrop.png'),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SettingsButton(
                title: "Change Theme",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                              "Select Primary Color",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            content: MaterialColorPicker(
                              selectedColor:
                                  currentTheme.getCurrentPrimarySwatch(),
                              colors: currentTheme.getColorSwatchOptions(),
                              allowShades: false,
                              onMainColorChange: (color) {
                                currentTheme
                                    .setPrimarySwatch(color as MaterialColor);
                              },
                            ),
                          ));
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: SettingsButton(
                  title: 'Credits',
                  onPressed: () {
                    showDialog(context: context, builder: ((context) => const Credits()));
                  },
                )),
          ],
        )),
      ),
    );
  }
}
