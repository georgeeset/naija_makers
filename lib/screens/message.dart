import 'package:flutter/material.dart';

import '../widgets/mail.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          body:ListView(
            children: <Widget>[
              Container(padding: EdgeInsets.only(right: 5),
                child: MailWidget(null)),
            ],
      ),
    );
  }
}