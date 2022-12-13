import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Theme_Data");

class AppTheme with ChangeNotifier {
  Map<String, MaterialColor> primarySwatchesDictionary = {
    'red': Colors.red,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'blue': Colors.blue,
    'green': Colors.green,
    'pink': Colors.pink,
    'brown' : Colors.brown,
    'lightBlue' : Colors.lightBlue,
    'orange' : Colors.orange,
    
  };

  MaterialColor getCurrentPrimarySwatch() {
    if (_myBox.containsKey("CURRENT_PRIMARY_SWATCH")) {
      String fetchedPrimarySwatchString = _myBox.get("CURRENT_PRIMARY_SWATCH");
      return primarySwatchesDictionary[fetchedPrimarySwatchString]!;
    } else {
      setPrimarySwatch(primarySwatchesDictionary["pink"]!);
      return primarySwatchesDictionary["pink"]!;
    }
  }

  void setPrimarySwatch(MaterialColor color) {
    String colorKey = primarySwatchesDictionary.keys.firstWhere((value) => primarySwatchesDictionary[value] == color);
    _myBox.put("CURRENT_PRIMARY_SWATCH", colorKey);
    notifyListeners();
  }

  List<MaterialColor> getColorSwatchOptions() {
    List<MaterialColor> colorSwatchOptions =  primarySwatchesDictionary.values.toList();
    return colorSwatchOptions;
  }
}
