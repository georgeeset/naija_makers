import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  final String titleText;
  final String bodyText;
  final String goodOption;
  final String badOption;
  ActionDialog(
      {this.titleText, this.bodyText, this.goodOption, this.badOption});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Icon(
          Icons.warning,
          color: Colors.red,
          size: 20,
        ),
        Text(titleText)
      ]),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      content: Container(
        child: Text(bodyText),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(goodOption),
        ),
        Container(
          width: 20,
        ),
        OutlineButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(badOption),
        ),
      ],
      contentTextStyle: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
