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
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF252525), // Lighter dark background
  cardColor: const Color(0xFF383838), // Lighter card color
  colorScheme: const ColorScheme.dark(
    primary: Colors.blueAccent,
    secondary: Colors.white,
    tertiary: Colors.white12,
    surface: Color(0xFF383838),
    background: Color(0xFF252525),
  ),
  fontFamily: 'Noto',
);
