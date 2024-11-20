import 'package:flutter/material.dart';

class Providerapp with ChangeNotifier {
  ThemeMode theme = ThemeMode.system;
  changemode(bool isdark) {
    theme = isdark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
