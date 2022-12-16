import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:reading_habbit_and_page_tracker/config.dart';
import 'package:reading_habbit_and_page_tracker/database/bookmark_database.dart';
import 'package:reading_habbit_and_page_tracker/utils/dialogues/credits.dart';

import '../utils/custom_buttons/settings_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {super.key,
      required this.databaseReference,
      required this.setShowCalendarPrefCallback,
      required this.getShowCalendarPrefCallback});

  final BookmarksDatabase databaseReference;
  final Function setShowCalendarPrefCallback;
  final Function getShowCalendarPrefCallback;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

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
            child: ClipRect(
              clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0),
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              height: 300,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 63,
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Show Calendar",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Switch(
                            value:
                                widget.databaseReference.getShowCalendarPref(),
                            onChanged: (newValue) {
                              setState(() {
                                widget.setShowCalendarPrefCallback(newValue);
                              });
                            }),
                      ],
                    ),
                  ),
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
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  content: MaterialColorPicker(
                                    selectedColor:
                                        currentTheme.getCurrentPrimarySwatch(),
                                    colors:
                                        currentTheme.getColorSwatchOptions(),
                                    allowShades: false,
                                    onMainColorChange: (color) {
                                      currentTheme.setPrimarySwatch(
                                          color as MaterialColor);
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
                          showDialog(
                              context: context,
                              builder: ((context) => const Credits()));
                        },
                      )),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
