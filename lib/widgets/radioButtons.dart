import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Class that encapsulates two buttons as a pair of radio buttons
class RadioButtons extends StatefulWidget {
  // The constructor requires the text and the value of the two buttons
  RadioButtons({
    Key? key,
    this.textButton1,
    this.valueButton1,
    this.textButton2,
    this.valueButton2,
    this.setFunc,
  }) : super(key: key);

  // Texts of the buttons
  final String? textButton1;
  final String? textButton2;

  // Buttons values
  final String? valueButton1;
  final String? valueButton2;

  // The 'setFunc' is the function used to set a variable in the parent widget
  final Function? setFunc;

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

// Class that encapsulates two buttons as a pair of radio buttons
class _RadioButtonsState extends State<RadioButtons> {
  // Ensure only one button is active at given time
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      // Create the two buttons
      children: <Widget>[
        _singleButton(
          context,
          widget.textButton1,
          widget.valueButton1,
          selected,
        ),
        _singleButton(
          context,
          widget.textButton2,
          widget.valueButton2,
          !selected,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  // Generate a single button
  Widget _singleButton(context, text, value, active) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 5.0,
                )
              ],
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return Theme.of(context).colorScheme.primary;
                return Colors.grey; // Use the component's default.
              },
            ),
          ),

          // Check if the buttons is active and take action
          onPressed: active ? () => _changeActiveButton() : null,
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.08,
      ),
    );
  }

  // Change the active button and call the 'setFunc' from the parend widget
  _changeActiveButton() {
    setState(() {
      // Change active button value
      selected = !selected;

      // Based on which button is active set a value
      if (selected)
        widget.setFunc!(widget.valueButton2);
      else
        widget.setFunc!(widget.valueButton1);
    });
  }
}
