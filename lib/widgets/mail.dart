import 'dart:io';

import 'package:flutter/material.dart';
import 'package:naija_makers/screens/profile.dart';

class MailWidget extends StatelessWidget {
  final File _image;

  MailWidget(this._image);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: mediaQueryData.size.width - 40,
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(
              2,
              2,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            //  onTap: (){
            //    Navigator.pushNamed(
            //      context,
            //      ProfilePage.routName,
            //      arguments: ScreenArguments(
            //        title: 'Full Name',
            //        isMaker: true, //or false
            //      )
            //    );
            //  },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black, //Theme.of(context).primaryColor,
              child: ClipOval(
                  child: Container(
                height: 75.0,
                width: 75.0,
                color: Colors.green,
                child: _image == null ? Container() : Image.file(_image),
              )),
            ),
          ),
          Container(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        width: mediaQueryData.size.width * .5,
                        child: Flexible(
                          child: Text(
                            'Full Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    Text(
                        '12:22 PM') //if today time if yesterday, yesterday, if before yesterday, date
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      width: mediaQueryData.size.width * .5,
                      child: Text(
                        'the last Message message is too long for me to handle without spilling over the border',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Icon(Icons.add), // icons shoould indicaat delivered and sent
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Theme.of(context).accentColor,
                    child: FittedBox(
                      child: Text('21'),
                    ), // number of unread messages
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
