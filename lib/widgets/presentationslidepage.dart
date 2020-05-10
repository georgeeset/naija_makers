import 'package:flutter/material.dart';

class PresentationSlidePage extends StatelessWidget {
  final String title;
  final String note;
  final Color bgColor;
  PresentationSlidePage(this.title,this.note,this.bgColor,);

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(

      width: double.infinity,

      padding: EdgeInsets.all(20),
      color:bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text(title,style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,color:Colors.black),),
        Container(height: 100,),
        Text(note,style: Theme.of(context).textTheme.title.copyWith(fontStyle: FontStyle.italic,fontWeight: FontWeight.w600,color: Colors.white),),
      ],),
    ),);
      
  }
}