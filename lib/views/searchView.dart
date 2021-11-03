import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mensa_uniurb/themes.dart';
import 'package:mensa_uniurb/views/resultView.dart';
import 'package:mensa_uniurb/widgets/circleAppBar.dart';
import 'package:mensa_uniurb/widgets/datePicker.dart';
import 'package:mensa_uniurb/widgets/drawer.dart';
import 'package:mensa_uniurb/widgets/radioButtons.dart';

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
      drawer: getDrawer(
        context,
        widget.theme,
      ),
    );
  }

  // Callbacks for child widgets
  _kitchenCallback(value) => kitchen = value;
  _dateCallback(value) => date = value;
  _mealCallback(value) => meal = value;
}
