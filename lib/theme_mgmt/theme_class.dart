import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Theme_Data");

class AppTheme with ChangeNotifier {
  Map primarySwatchesDictionary = {
    'red': Colors.red,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'blue': Colors.blue,
    'green': Colors.green,
    'pink': Colors.pink,
  };

  MaterialColor getCurrentPrimarySwatch() {
    // TODO: Get primary color set from Hive
    if (_myBox.containsKey("CURRENT_PRIMARY_SWATCH")) {
      String fetchedPrimarySwatchString = _myBox.get("CURRENT_PRIMARY_SWATCH");
      return primarySwatchesDictionary[fetchedPrimarySwatchString];
    } else {
      setPrimarySwatch('yellow');
      return primarySwatchesDictionary["yellow"];
    }
  }

  void setPrimarySwatch(String color) {
    // TODO: Use Hive to set primary color
    _myBox.put("CURRENT_PRIMARY_SWATCH", color);
    notifyListeners();
  }
}
