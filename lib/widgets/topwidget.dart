
import 'package:flutter/material.dart';



class TopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(
             mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             
              CircleAvatar(backgroundColor: Colors.green,radius: 40,),
            ],
          );
  }
}