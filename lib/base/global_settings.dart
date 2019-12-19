import 'package:flutter/material.dart';

class GlobalSetting {
  static bool isDebug() {
    bool result = false;
    assert(() {
      result = true;
    }());
    return result;
  }

  static ThemeData defaultTheme = new ThemeData(primaryColor: Colors.amber);
  static ThemeData amberTheme = new ThemeData(primaryColor: Colors.amber);

  static setThemeDark() {}
}
