import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:provider/provider.dart';

class ColorPickerCard extends StatelessWidget {
  final int colorIndex;
  final bool whiteColor;
  ColorPickerCard({this.colorIndex,this.whiteColor=false});
  
  @override
  Widget build(BuildContext context) {
    final newPost=Provider.of<NewPostProvider>(context,listen: false);

    return Card(
        elevation: 2.5,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            child: InkWell(
                                  child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor ? Colors.white : Colors.primaries[colorIndex],
          ),
        ),

        onTap:(){
           FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
        Future.delayed(Duration(milliseconds: 600),()=>whiteColor? newPost.updateNoBgColor=true :  newPost.updateBgColor= colorIndex );
          
        }
            ),
      );
  }
}