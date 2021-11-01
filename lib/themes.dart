import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme with ChangeNotifier {
  ThemeData currentTheme = lightTheme;
  ThemeData get current => currentTheme;

  void switchTheme() {
    String theme;

    if (currentTheme == lightTheme) {
      currentTheme = darkTheme;
      theme = 'dark';
    } else {
      currentTheme = lightTheme;
      theme = 'light';
    }

    notifyListeners();
    save(theme);
  }

  // Save the theme to shared preferences
  save(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  // Load the theme from shared preferences
  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('theme') == 'dark') {
      currentTheme = darkTheme;
    } else {
      currentTheme = lightTheme;
    }
    notifyListeners();
  }
}

// Light-blue theme
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
  ),
  fontFamily: 'Noto',
);

// Dark-grey theme
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
  ),
  fontFamily: 'Noto',
);
