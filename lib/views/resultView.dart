import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mensa_uniurb/services/api.dart';
import 'package:mensa_uniurb/utils/apiQuery.dart';
import 'package:mensa_uniurb/utils/humanNames.dart';

class ResultView extends StatefulWidget {
  ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    ApiQuery query = ModalRoute.of(context)!.settings.arguments as ApiQuery;
    Future<List<Widget>> results = getList(query);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          humanNamesMap[query.kitchen] + " - " + humanNamesMap[query.meal],
        ),
      ),
      body: FutureBuilder(
        future: results,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            // Display loading animation
            return Center(child: CircularProgressIndicator());
          } else {
            List contentList = snapshot.data!;

            if (contentList.isNotEmpty) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(children: contentList as List<Widget>),
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
