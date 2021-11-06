
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

openUrl(BuildContext context, String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';

  // Close the drawer
  Navigator.pop(context);
}