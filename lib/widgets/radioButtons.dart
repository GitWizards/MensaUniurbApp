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
    double width = MediaQuery.of(context).size.width * 0.85;
    double height = MediaQuery.of(context).size.height * 0.075;

    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: active ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!active) {
                        setState(() {
                          active = true;
                          widget.callback(widget.value1);
                        });
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Center(
                      child: Text(
                        widget.text1,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: active
                              ? Colors.white
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (active) {
                        setState(() {
                          active = false;
                          widget.callback(widget.value2);
                        });
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Center(
                      child: Text(
                        widget.text2,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: !active
                              ? Colors.white
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
