import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/services/api.dart';
import 'package:mensa_uniurb/utils/apiQuery.dart';
import 'package:mensa_uniurb/utils/humanNames.dart';
import 'package:mensa_uniurb/widgets/mealTile.dart';

class ResultView extends StatefulWidget {
  ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    ApiQuery query = ModalRoute.of(context)!.settings.arguments as ApiQuery;
    Future<Map> results = getList(query);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          humanNamesMap[query.kitchen] + " - " + humanNamesMap[query.meal],
        ),
      ),
      body: FutureBuilder(
        future: results,
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (!snapshot.hasData) {
            // Display loading animation
            return Center(child: CircularProgressIndicator());
          } else {
            Map data = snapshot.data as Map;

            if (data.isNotEmpty) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(children: [
                      getMealTile(context, "Primo", data['menu']['first'], Icon(FontAwesomeIcons.pizzaSlice)),
                      getMealTile(context, "Secondo", data['menu']['second'], Icon(FontAwesomeIcons.hamburger)),
                      getMealTile(context, "Contorno", data['menu']['side'], Icon(FontAwesomeIcons.cheese)),
                      getMealTile(context, "Frutta/Dolce", data['menu']['fruit'], Icon(FontAwesomeIcons.iceCream)),
                    ]),
                  ),
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
}
