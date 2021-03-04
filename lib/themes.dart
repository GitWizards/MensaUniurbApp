import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme with ChangeNotifier {
  ThemeData _currentTheme = _blue;
  ThemeData get current => _currentTheme;

  void switchTheme(theme, {should_save = true}) {
    switch (theme) {
      case 'blue':
        _currentTheme = _blue;
        notifyListeners();
        break;
      case 'green':
        _currentTheme = _green;
        notifyListeners();
        break;
      case 'red':
        _currentTheme = _red;
        notifyListeners();
        break;
    }

    if (should_save) save(theme);
  }

  // Save the theme to shared preferences
  save(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  // Load the theme from shared preferences
  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');

    if (['blue', 'green', 'red'].contains(theme)) {
      switchTheme(
        theme,
        should_save: false,
      );
    } else {
      switchTheme('blue');
    }
  }
}

// Light - Blue theme
ThemeData _blue = ThemeData(
  primaryColor: Colors.blue,
  primarySwatch: Colors.blue,
  accentColor: Colors.blue,
  brightness: Brightness.light,
  fontFamily: 'Noto',
);

// Light - Green theme
ThemeData _green = ThemeData(
  primaryColor: Colors.green,
  primarySwatch: Colors.green,
  accentColor: Colors.green,
  brightness: Brightness.light,
  fontFamily: 'Noto',
);

// Dark - Red theme
ThemeData _red = ThemeData(
  primaryColor: Colors.red,
  primarySwatch: Colors.red,
  accentColor: Colors.red,
  brightness: Brightness.dark,
  fontFamily: 'Noto',
);
