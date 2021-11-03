import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/themes.dart';
import 'package:url_launcher/url_launcher.dart';

Container getDrawer(BuildContext context, MyTheme theme) {
  return Container(
    width: 250,
    color: Theme.of(context).backgroundColor,
    child: ListView(
      children: <Widget>[
        // Open github repo
        ListTile(
          leading: Icon(FontAwesomeIcons.github),
          title: Text('GitHub', style: TextStyle(fontSize: 17)),
          onTap: () => _launchURL(
            context,
            "https://github.com/FastRadeox/MensaUniurbBot",
          ),
        ),

        // Open telegram bot page
        ListTile(
          leading: Icon(FontAwesomeIcons.telegramPlane),
          title: Text('Bot Telegram', style: TextStyle(fontSize: 17)),
          onTap: () => _launchURL(
            context,
            "https://t.me/MensaUniurb_Bot",
          ),
        ),

        // Switch between dark and light theme
        ListTile(
          leading: Icon(FontAwesomeIcons.lightbulb),
          title: Text('Cambia tema', style: TextStyle(fontSize: 17)),
          onTap: () => {
            theme.switchTheme(),
            Navigator.pop(context),
          },
        ),
      ],
    ),
  );
}

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';

  // Close the drawer
  Navigator.pop(context);
}
