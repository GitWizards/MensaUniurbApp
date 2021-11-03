// Class that encapsulate a new button with a
// date text and a dataPicker
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DataPicker extends StatefulWidget {
  // Constructor
  DataPicker({Key? key, this.setFunc}) : super(key: key);

  // The 'setFunc' is the function used to set a variable in the parent widget
  final Function? setFunc;

  @override
  _DataPickerState createState() => _DataPickerState();
}

// Class that encapsulate a new button with a
// date text and a dataPicker
class _DataPickerState extends State<DataPicker> {
  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => _showDateTimePicker(context),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.09,
    );
  }

  // Shows the dataPicker to select a date
  _showDateTimePicker(BuildContext context) async {
    DateTime? selected;
    DateTime today = DateTime.now();
    Duration week = Duration(days: 7);

    // Get selected date
    selected = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(week),
      locale: const Locale("it", "IT"),
    );

    // Update the state and call the 'setFunc'
    setState(() {
      if (selected != null) {
        date = DateFormat('dd/MM/yyyy').format(selected);
        widget.setFunc!(DateFormat('MM-dd-yyyy').format(selected));
      }
    });
  }
}
