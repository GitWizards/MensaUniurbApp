import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

openUrl(BuildContext context, Uri url) async {
  if (await canLaunchUrl(url))
    await launchUrl(url);
  else
    throw 'Could not launch $url';

  // Close the drawer
  Navigator.pop(context);
}
