import 'package:flutter/material.dart';
import '../widgets/update_actions.dart';
import '../widgets/update_text.dart';

class UpdateTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData=MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      //height: 580,
      decoration: BoxDecoration(
         color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black45 ,blurRadius: 2.0, spreadRadius: 2.0,offset: Offset(2,2,),),],
      ),
     
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircleAvatar(backgroundColor: Colors.green,radius:45),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Poster name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('23 followers'),
                    Row(
                      children: <Widget>[
                        Container(width: 160,),
                        Text('23 min ago',style: TextStyle(color: Colors.green),),
                      ],
                    ),
                  ],
                ),
              )
            ],),
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(child: UpdateText(text:'Color red might be very confusing sometimes, it easily displays')),
           ),
           //optional container if only one picture is uploaded.
          Container(
            color: Colors.black,
           child: Container( color: Colors.red, height: 300,width:double.infinity)
          ),

          UpdateActions()
          //optional listView.builder if picutes uploaded is many

      ],),

    );
  }

  Widget textOnly(String text,Color bgColor,MediaQueryData mediaQueryData){
    return Container(
      height: mediaQueryData.size.width,
      color: bgColor,
      child: Center(child: Text(text),),
    );

  }
}