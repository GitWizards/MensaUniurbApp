

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/themes.dart';
import 'package:intl/intl.dart';
import 'package:mensa_uniurb/views/resultView.dart';
import 'package:mensa_uniurb/widgets/circleAppBar.dart';
import 'package:mensa_uniurb/widgets/datePicker.dart';
import 'package:mensa_uniurb/widgets/radioButtons.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchView extends StatefulWidget {
  final String title;
  final MyTheme theme;

  SearchView({
    Key? key,
    required this.title,
    required this.theme,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String kitchen = "duca";
  String date = DateFormat('MM-dd-yyyy').format(DateTime.now());
  String meal = "lunch";

  // Translates values from buttons to prettier form
  Map prettyName = {
    'duca': "Duca",
    'tridente': "Tridente",
    'lunch': "Pranzo",
    'dinner': "Cena",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 24)),
        centerTitle: true,
        flexibleSpace: CustomPaint(
          painter: CircleAppBar(context: context),
          child: Container(padding: EdgeInsets.only(top: 80.0)),
        ),
      ),

      body: Container(
        padding: EdgeInsets.only(top: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: RadioButtons(
                text1: prettyName["duca"],
                value1: "duca",
                text2: prettyName["tridente"],
                value2: "tridente",
                callback: _kitchenCallback,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: RadioButtons(
                text1: prettyName["lunch"],
                value1: "lunch",
                text2: prettyName["dinner"],
                value2: "dinner",
                callback: _mealCallback,
              ),
            ),
            // Custom data picker
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: DataPicker(
                setFunc: _dateCallback,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text("Cerca"),
        icon: Icon(Icons.search),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          String? chosenKitchen = prettyName['$kitchen'];
          String? chosenMeal = prettyName['$meal'];

          // Navigate to ResultScreen when tapped
          Navigator.pushNamed(
            context,
            '/results',
            arguments: SearchArguments(
              title: "$chosenKitchen - $chosenMeal",
              kitchen: kitchen,
              date: date,
              meal: meal,
            ),
          );
        },
      ),

      // Drawer
      drawer: Container(
        width: 250,
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            // Open github repo
            ListTile(
              leading: Icon(FontAwesomeIcons.github),
              title: Text('GitHub', style: TextStyle(fontSize: 17)),
              onTap: () =>
                  _launchURL("https://github.com/FastRadeox/MensaUniurbBot"),
            ),

            // Open telegram bot page
            ListTile(
              leading: Icon(FontAwesomeIcons.telegramPlane),
              title: Text('Bot Telegram', style: TextStyle(fontSize: 17)),
              onTap: () => _launchURL("https://t.me/MensaUniurb_Bot"),
            ),

            // Switch between dark and light theme
            ListTile(
              leading: Icon(FontAwesomeIcons.lightbulb),
              title: Text('Cambia tema', style: TextStyle(fontSize: 17)),
              onTap: () => {
                widget.theme.switchTheme(),
                Navigator.pop(context),
              },
            ),
          ],
        ),
      ),
    );
  }

  // Callbacks for child widgets
  _kitchenCallback(value) => kitchen = value;
  _dateCallback(value) => date = value;
  _mealCallback(value) => meal = value;

  _launchURL(url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';

    // Close the drawer
    Navigator.pop(context);
  }
}