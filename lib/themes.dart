import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme with ChangeNotifier {
  ThemeData _currentTheme = _blue;

  ThemeData get current => _currentTheme;

  void switchTheme(theme) {
    switch (theme) {
      case 'blue':
        _currentTheme = _blue;
        notifyListeners();
        save('blue');
        break;
      case 'green':
        _currentTheme = _green;
        notifyListeners();
        save('green');
        break;
      case 'red':
        _currentTheme = _red;
        notifyListeners();
        save('red');
        break;
    }
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

    // If theme exists return it, otherwise return default theme
    switch (theme) {
      case 'blue':
        _currentTheme = _blue;
        break;

      case 'green':
        _currentTheme = _green;
        break;

      case 'red':
        _currentTheme = _red;
        break;

      default:
        _currentTheme = _blue;
        break;
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
