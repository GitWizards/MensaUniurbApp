import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/themes.dart';
import 'package:mensa_uniurb/utils/browser.dart';

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
          subtitle: Text('The old ways'),
          onTap: () => openUrl(
            context,
            Uri.parse("https://t.me/MensaUniurb_Bot"),
          ),
        ),

        // Open telegram bot page
        ListTile(
          leading: Icon(FontAwesomeIcons.peopleCarryBox),
          title: Text('Contattaci', style: TextStyle(fontSize: 17)),
          subtitle: Text('Segnala problemi'),
          onTap: () => openUrl(
            context,
            Uri.parse("https://t.me/Radeox"),
          ),
        ),

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
                          "I risultati non dipendono da noi ma sono inseriti dai dipendenti ERDIS.",
                        ),
                        Text(
                          "Questa applicazione è fatta da studenti e non è collegata in alcun modo ad Uniurb o ERDIS.",
                        ),
                        Text("------------------------------"),
                        Text(
                          "Se vuoi aiutarci a sostenere il progetto puoi fare una donazione seguendo le istruzioni nel bot usando /dona.",
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
      ],
    ),
  );
}
