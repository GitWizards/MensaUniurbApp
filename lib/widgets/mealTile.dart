import 'package:flutter/material.dart';
import 'package:mensa_uniurb/utils/humanNames.dart';

Widget getMealTile(
    BuildContext context, String title, List children, Icon icon) {
  return ExpansionTile(
      initiallyExpanded: true,
      iconColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.secondary,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      children: children.map((child) {
        return ListTile(title: Text("• " + child));
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
