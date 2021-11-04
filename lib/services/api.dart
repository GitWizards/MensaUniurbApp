import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:mensa_uniurb/utils/apiQuery.dart';
import 'package:mensa_uniurb/utils/humanNames.dart';

Future<List<Widget>> getList(ApiQuery args) async {
  // const String BackendUrl = 'radeox.duckdns.org:9543';
  const String BackendUrl = '4ace-37-183-79-82.ngrok.io';
  List<Widget> resultList = [];
  Map data = {};

  Uri uri = Uri.http(
    BackendUrl,
    '${args.kitchen}/${args.date}/${args.meal}',
  );

  // Send the request and decode response.
  try {
    Response response = await get(uri);
    data = json.decode(response.body);
  } on Exception {}

  // If the json is empty, return an empty list
  if (data.isEmpty) return resultList;

  for (String type in data['menu'].keys) {
    resultList.add(namedSpacer('${humanNamesMap[type]}'));

    for (String item in data['menu'][type]) {
      String infos = item.replaceAll(RegExp(r'[A-z][^F|f0-9]'), '').trim();
      item = item.replaceAll(RegExp(r'[-]?[F|f]?[0-9].?'), '').trim();

      // Check if it contains allergry infos
      RegExp filter = RegExp('([0-9])');

      if (filter.hasMatch(infos)) {
        // Remove info about allergens from the original string
        // and add them in the exapanded tile child
        item = item.replaceAll(infos, '');
        infos = infos.toUpperCase();

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

        resultList.add(
          Card(
            child: ExpansionTile(
              title: Text('$item'),
              children: infoList,
            ),
          ),
        );
      } else {
        // Otherwise add it without anything
        resultList.add(
          Card(
            child: ListTile(
              title: Text('$item'),
            ),
          ),
        );
      }
    }
  }

  return resultList;
}

Widget namedSpacer(value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(8.0),
        child: Icon(FontAwesomeIcons.utensils),
      ),
      Container(
        padding: EdgeInsets.all(8.0),
        child: Text(value, style: TextStyle(fontSize: 25)),
      ),
    ],
  );
}
