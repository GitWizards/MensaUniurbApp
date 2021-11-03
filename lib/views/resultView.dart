import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class ResultView extends StatefulWidget {
  // Constructor of the screen
  ResultView({Key? key, this.title}) : super(key: key);

  // Title of the screen
  final String? title;

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  // Flag to check if data has been already requested
  bool needData = true;

  // Arguments of the search
  SearchArguments? args;

  // Future list of widgets that will be made in the getList function
  Future<List<Widget>>? results;

  @override
  Widget build(BuildContext context) {
    if (needData) {
      // Extract arguments passed from the search screen
      args = ModalRoute.of(context)!.settings.arguments as SearchArguments?;
      results = getList(args!);

      // Set flag to false
      needData = false;
    }

    return Scaffold(
      appBar: AppBar(title: Text("${args!.title}")),
      body: FutureBuilder(
        future: results,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            // Display loading animation
            return Center(child: CircularProgressIndicator());
          } else {
            List content = snapshot.data!;

            // If some content exists
            if (content.isNotEmpty) {
              // Create and return the list
              return Column(
                children: <Widget>[
                  Expanded(child: ListView(children: content as List<Widget>)),
                ],
              );
            } else {
              // If the result is empty display alert
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.red,
                    ),
                    Text("Ops!", style: TextStyle(fontSize: 50)),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                      ),
                      child: Text(
                        "Sembra che la mensa sia chiusa.",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Widget>> getList(SearchArguments args) async {
    // Result of the request to API
    Map? result = {};

    // Create an empty list
    List<Widget> list = [];

    Map names = {
      'first': "Primi",
      'second': "Secondi",
      'side': "Contorni",
      'fruit': "Frutta",
    };

// Map allergens codes to correct string
    Map allergensMap = {
      "1": "Glutine",
      "2": "Corstacei",
      "3": "Uova",
      "4": "Pesce",
      "5": "Arachidi",
      "6": "Soia",
      "7": "Latte",
      "8": "Frutta a guscio",
      "9": "Sedano",
      "10": "Senape",
      "11": "Semi di sesamo",
      "12": "Anidride solforosa e solfiti",
      "13": "Lupini",
      "14": "Molluschi",
    };

    // Make the url with the arguments from the previous screen
    Uri uri = Uri.http(
      'radeox.duckdns.org:9543',
      '${args.kitchen}/${args.date}/${args.meal}',
    );

    // Send the request
    Response response = await get(uri);

    // Try decoding results
    // If they are empty the result will not be a JSON
    try {
      result = json.decode(response.body);
    } on Exception {}

    // If no results (network/request error) or the
    //results are empty (closing day) then return the empty list
    if ((result!.isEmpty) || (result['menu']['first'].isEmpty)) return list;

    // Loop through keys of the json
    for (String type in result['menu'].keys) {
      list.add(namedSpacer('${names[type]}'));

      // Loop through each item and add them to list
      for (String item in result['menu'][type]) {
        String infos = item.replaceAll(RegExp(r'[A-z][^F|f0-9]'), '').trim();
        item = item.replaceAll(RegExp(r'[-]?[F|f]?[0-9].?'), '').trim();

        // Check if it contains allergry infos
        RegExp filter = RegExp('([0-9])');

        if (filter.hasMatch(infos)) {
          // Remove info about allergens from the original string
          // and add them in the exapanded tile child
          item = item.replaceAll(infos, '');
          infos = infos.toUpperCase();

          // Create a list with all the allergens
          List<Widget> infoList = [];
          infos.split('-').forEach((info) => {
                // Remove the 'F' from the info (optional)
                if (info.contains("F"))
                  {
                    info = info.replaceAll("F", ""),
                    if (allergensMap.containsKey(info))
                      infoList.add(
                        ListTile(
                          title: Text(
                            "+ " + allergensMap[info],
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                  }
                else
                  {
                    if (allergensMap.containsKey(info))
                      infoList.add(
                        ListTile(
                          title: Text("• " + allergensMap[info]),
                        ),
                      ),
                  }
              });

          // Add the new item
          list.add(
            Card(
              child: ExpansionTile(
                title: Text('$item'),
                children: infoList,
              ),
            ),
          );
        } else {
          // Otherwise add it without anything
          list.add(
            Card(
              child: ListTile(
                title: Text('$item'),
              ),
            ),
          );
        }
      }
    }

    return list;
  }

  Widget namedSpacer(value) {
    return Row(
      children: <Widget>[
        // Icon
        Container(
          padding: EdgeInsets.all(8.0),
          child: Icon(FontAwesomeIcons.utensils),
        ),

        // Text
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(value, style: TextStyle(fontSize: 25)),
        ),
      ],

      // Allignment
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}

// Class that incapsulates the arguments required for the search query
class SearchArguments {
  // Constructor of the arguments
  SearchArguments({
    required this.title,
    required this.kitchen,
    required this.date,
    required this.meal,
  });

  // Kitchen name
  final String title;

  // Kitchen name
  final String kitchen;

  // Date in MM-DD-YYYY format
  final String date;

  // Meal (lunch or dinner)
  final String meal;
}
