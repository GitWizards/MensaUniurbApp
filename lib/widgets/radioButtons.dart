import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  RadioButtons({
    Key? key,
    required this.text1,
    required this.value1,
    required this.text2,
    required this.value2,
    required this.callback,
  }) : super(key: key);

  final String text1;
  final String text2;
  final String value1;
  final String value2;
  final Function callback;

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        createRadioButton(
          context,
          widget.text1,
          widget.value1,
          active,
        ),
        createRadioButton(
          context,
          widget.text2,
          widget.value2,
          !active,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget createRadioButton(
    BuildContext context,
    String text,
    String value,
    bool state,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        child: ElevatedButton(
          child: Text(
            text,
            style: buttonStyle(state),
          ),
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(2),
            shape: WidgetStateProperty.all<OutlinedBorder>(StadiumBorder()),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (state) {
                  return Theme.of(context).colorScheme.primary;
                } else {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.15);
                }
              },
            ),
          ),
          onPressed: () => state ? null : toggleButton(),
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.08,
      ),
    );
  }

  void toggleButton() {
    setState(() {
      active = !active;
      active ? widget.callback(widget.value1) : widget.callback(widget.value2);
    });
  }

  TextStyle buttonStyle(bool state) {
    if (state) {
      return TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.07,
        color: Theme.of(context).colorScheme.secondary,
      );
    } else {
      return TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.07,
        color: Theme.of(context).colorScheme.tertiary,
      );
    }
  }
}
