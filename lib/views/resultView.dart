import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
    Future<Map> results = getList(query);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              humanNamesMap[query.kitchen] + " - " + humanNamesMap[query.meal],
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('dd/MM/yy')
                  .format(DateFormat('MM-dd-yyyy').parse(query.date)),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
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
              return Container(
                margin: EdgeInsets.all(8),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  children: [
                    MenuSectionCard(
                      title: "Primo",
                      items: data['menu']['first'],
                      icon: FontAwesomeIcons.bowlFood,
                      accentColor: Colors.amber,
                    ),
                    MenuSectionCard(
                      title: "Secondo",
                      items: data['menu']['second'],
                      icon: FontAwesomeIcons.drumstickBite,
                      accentColor: Colors.redAccent,
                    ),
                    MenuSectionCard(
                      title: "Contorno",
                      items: data['menu']['side'],
                      icon: FontAwesomeIcons.carrot,
                      accentColor: Colors.lightGreen,
                    ),
                    MenuSectionCard(
                      title: "Frutta/Dolce",
                      items: data['menu']['fruit'],
                      icon: FontAwesomeIcons.appleWhole,
                      accentColor: Colors.lightBlue,
                    ),
                  ],
                ),
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
                        "Sembra che la mensa sia chiusa!",
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

class MenuSectionCard extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final IconData icon;
  final Color accentColor;

  const MenuSectionCard({
    Key? key,
    required this.title,
    required this.items,
    required this.icon,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Basic verification for dark mode to adjust shadows or backgrounds if needed
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final shadowColor = isDarkMode ? Colors.black26 : Colors.black12;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background Faded Icon
          Positioned(
            bottom: -20,
            right: -20,
            child: Icon(
              icon,
              size: 140,
              color: accentColor.withOpacity(0.15),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Colored Strip
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                       color: accentColor,
                       // Ensure the strip respects the border radius on the left side
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12),
                        if (items.isEmpty)
                          Text(
                            "Nessuna opzione disponibile",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).hintColor,
                            ),
                          )
                        else
                          ...items.map((item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "• ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.toString().trim(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
