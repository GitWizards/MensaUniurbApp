import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/themes.dart';
import 'package:mensa_uniurb/utils/browser.dart';

Container getDrawer(BuildContext context, MyTheme theme) {
  return Container(
    width: 250,
    color: Theme.of(context).cardColor,
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: Center(
            child: Image.asset(
              'img/logo.png',
              height: 120,
            ),
          ),
        ),

        // Open github repo
        ListTile(
          leading: Icon(FontAwesomeIcons.github),
          title: Text('GitHub', style: TextStyle(fontSize: 17)),
          subtitle: Text('Only for nerds'),
          onTap: () => openUrl(
            context,
            Uri.parse("https://github.com/FastRadeox/MensaUniurbApp"),
          ),
        ),

        // Open telegram bot page
        ListTile(
          leading: Icon(FontAwesomeIcons.telegram),
          title: Text('Bot Telegram', style: TextStyle(fontSize: 17)),
          subtitle: Text('The classic'),
          onTap: () => openUrl(
            context,
            Uri.parse("https://t.me/MensaUniurb_Bot"),
          ),
        ),

        // Switch between dark and light theme
        ListTile(
          leading: Icon(FontAwesomeIcons.lightbulb),
          title: Text('Cambia tema', style: TextStyle(fontSize: 17)),
          subtitle: Text('Join the Dark side'),
          onTap: () => {
            theme.switchTheme(),
            Navigator.pop(context),
          },
        ),

        // Info button
        ListTile(
          leading: Icon(FontAwesomeIcons.question),
          title: Text('Info', style: TextStyle(fontSize: 17)),
          subtitle: Text('Disclaimer and about'),
          onTap: () => {
            Navigator.pop(context),
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Info'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          "I risultati mostrati sono inseriti direttamente dal personale ERDIS e non dipendono dallo sviluppo di questa app.",
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Questa applicazione è un progetto studentesco indipendente e non è affiliata in alcun modo con l'Università di Urbino (Uniurb) o con l'Ente Regionale per il Diritto allo Studio (ERDIS).",
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          },
        ),
      ],
    ),
  );
}
