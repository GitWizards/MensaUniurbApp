import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

openUrl(BuildContext context, Uri url) async {
  // Close the drawer first
  Navigator.pop(context);

  try {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error launching URL: $e')),
    );
  }
}
