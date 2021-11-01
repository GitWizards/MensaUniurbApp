

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
  // Title of the screen
  final String title;
  final MyTheme theme;

  // Constructor of the screen
  SearchView({
    Key? key,
    required this.title,
    required this.theme,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

// Widget that creates the form search and send the query to the result widget
class _SearchViewState extends State<SearchView> {
  // Variables that stores user choices for later use
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
      // Top appbar with title
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 24)),
        centerTitle: true,
        // Makes the cool circle over appbar
        flexibleSpace: CustomPaint(
          painter: CircleAppBar(context: context),
          child: Container(padding: EdgeInsets.only(top: 80.0)),
        ),
      ),

      // Body of the screen
      body: Container(
        padding: EdgeInsets.only(top: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              // Custom radio buttons
              child: RadioButtons(
                textButton1: prettyName["duca"],
                valueButton1: "duca",
                textButton2: prettyName["tridente"],
                valueButton2: "tridente",
                setFunc: _setKitchen,
              ),
            ),
            // Custom radio buttons
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: RadioButtons(
                textButton1: prettyName["lunch"],
                valueButton1: "lunch",
                textButton2: prettyName["dinner"],
                valueButton2: "dinner",
                setFunc: _setMeal,
              ),
            ),
            // Custom data picker
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: DataPicker(
                setFunc: _setDate,
              ),
            ),
          ],
        ),
      ),

      // Button to start query
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Cerca"),
        icon: Icon(Icons.search),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          // Translates values from buttons to prettier form
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

  // Function called from child widgets to set the value
  _setKitchen(value) => kitchen = value;

  // Function called from child widgets to set the value
  _setDate(value) => date = value;

  // Function called from child widgets to set the value
  _setMeal(value) => meal = value;

  // Open URL in browser
  _launchURL(url) async {
    // Check if can launch URL
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';

    // Close the drawer
    Navigator.pop(context);
  }
}