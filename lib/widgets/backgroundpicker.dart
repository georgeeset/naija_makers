import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundPicker extends StatelessWidget {
  final double width;
  final Function uploadButtonTapped;
  BackgroundPicker(this.width,this.uploadButtonTapped);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            //  height: 35,
            // width: width/1.5,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.primaries[Random().nextInt(10)],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: 5,
                  height: 40,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Text(
                    'Upload',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Icon(Icons.attach_file),
                ],
              ),
              onPressed: () => uploadButtonTapped(context), //command modalBottom sheet now now
            ),
          )
        ],
      ),
    );
  }
}
