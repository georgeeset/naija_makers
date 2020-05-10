import 'package:flutter/material.dart';

class UpdateText extends StatefulWidget {

  final String text;
  UpdateText({this.text});

  @override
  _UpdateTextState createState() => _UpdateTextState();
}

class _UpdateTextState extends State<UpdateText> 
  with TickerProviderStateMixin{
  bool isExpanded=false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            AnimatedSwitcher(duration: Duration(milliseconds:400),
                 switchInCurve: Curves.easeIn,
                 switchOutCurve: Curves.easeOut,
                 transitionBuilder: (Widget child, Animation<double>animation){
                   return SizeTransition (child: child,sizeFactor: animation,);
                 },
                  child:  SelectableText(widget.text,
                 key: ValueKey<bool>(isExpanded),maxLines: isExpanded ? null : 1,textAlign: TextAlign.start,),
                 ),
              
              (widget.text.length>53 || widget.text.contains('\n'))? InkWell(
                onTap: (){ setState(() {
                isExpanded = !isExpanded; 
                }); },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    isExpanded ? Text("Show Less",style: TextStyle(color: Colors.green),) :  Text("Show More",style: TextStyle(color: Colors.green))
                  ],
                ),
              ):
              Container(),
          ],
        ),
      );
  }
}