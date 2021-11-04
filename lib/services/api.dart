import 'dart:convert';
import 'package:http/http.dart';
import 'package:mensa_uniurb/utils/apiQuery.dart';

Future<Map> getList(ApiQuery args) async {
  const String BackendUrl = 'radeox.duckdns.org:9543';
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
  if (data.isEmpty) return {};

  return data;
}
