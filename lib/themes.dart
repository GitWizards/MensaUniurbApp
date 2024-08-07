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

  save(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

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
    secondary: Colors.white,
    tertiary: Colors.black26,
  ),
  fontFamily: 'Noto',
);

// Dark-grey theme
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.black26,
    secondary: Colors.white,
    tertiary: Colors.white12,
  ),
  fontFamily: 'Noto',
);
