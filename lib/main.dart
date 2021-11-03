import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mensa_uniurb/views/resultView.dart';
import 'package:mensa_uniurb/views/searchView.dart';

import 'themes.dart';

void main() async {
  // Lock app in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Load previously selected theme
  MyTheme theme = MyTheme();
  theme.load();

  runApp(MensaUniurb(theme: theme));
}

class MensaUniurb extends StatefulWidget {
  final String title = "Mensa Uniurb";
  final MyTheme theme;

  MensaUniurb({required this.theme});

  @override
  _MensaUniurbState createState() => _MensaUniurbState();
}

class _MensaUniurbState extends State<MensaUniurb> {
  @override
  void initState() {
    super.initState();
    widget.theme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: widget.theme.current,

      // Define application routes to various views
      initialRoute: '/',
      routes: {
        '/': (context) => SearchView(
              title: widget.title,
              theme: widget.theme,
            ),
        '/results': (context) => ResultView(),
      },

      // Localization settings for calendar
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('it'),
      ],
    );
  }
}
