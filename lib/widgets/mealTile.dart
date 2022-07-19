import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mensa_uniurb/utils/humanNames.dart';

Widget getMealTile(
    BuildContext context, String title, List children, Icon icon) {
  return ExpansionTile(
      initiallyExpanded: true,
      iconColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.primary,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      children: children.map((child) {
        return ListTile(
          title: Text("• " + removeIngredients(child)),
          trailing: parseIngredients(child).isNotEmpty
              ? IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleInfo,
                    size: 15,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Lista allergeni'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: parseIngredients(child),
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
                    );
                  },
                )
              : null,
        );
      }).toList());
}

List<Widget> parseIngredients(String item) {
  List<Widget> allergenList = [];

  // Clean up the string
  String allergens = item.replaceAll(RegExp(r'[A-z][^F|f0-9]'), '').trim();
  allergens = allergens.toUpperCase();

  RegExp filter = RegExp('([0-9])');

  if (filter.hasMatch(allergens)) {
    allergens.split('-').forEach((allergen) => {
          // Remove the 'F' from the info (optional)
          if (allergen.contains("F"))
            {
              allergen = allergen.replaceAll("F", ""),
              if (allergensMap.containsKey(allergen))
                allergenList.add(
                  Text("+ " + allergensMap[allergen] + " (facoltativo)"),
                ),
            }
          else
            {
              if (allergensMap.containsKey(allergen))
                allergenList.add(
                  Text("• " + allergensMap[allergen]),
                )
            }
        });
  }

  return allergenList;
}

String removeIngredients(String item) {
  String allergens = item.replaceAll(RegExp(r'[A-z][^F|f0-9]'), '').trim();
  item = item.replaceAll(RegExp(r'[-]?[F|f]?[0-9].?'), '').trim();
  item = item.replaceAll(allergens, '');

  return item;
}
