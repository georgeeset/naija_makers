

import 'package:flutter/material.dart';

class GreenClip extends CustomClipper<Path>{

  //var radius=10.0;
 
  @override
  Path getClip(Size size) {
    double pointb=size.height/2;
    var path= new Path();
    path.lineTo(0.0, size.height);
      path.lineTo(size.width,pointb);
      path.lineTo(size.width,0.0);
       
    path.close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}

class WhiteClip extends CustomClipper<Path>{

  @override
  Path getClip(Size size){

    //var firstEndPoint= Offset(0.0,size.height/2);
    var firstControlPoint=Offset(size.width/4,(size.height*(3/4))); //this means the curved point
    var firstEndPoint=Offset(size.width/2,size.height*.65); // this means the pivolt point

    var secondControlPoint=Offset(size.width*(3/4),size.height); // next curved point
    var secondEndPoint=Offset(size.width,size.height);// end of curve
   
    var path= new Path();
      path.lineTo(0.0,size.height/4);
      //draw your curve in betweeen this two point

      path.quadraticBezierTo(firstControlPoint.dx,firstControlPoint.dy,
                             firstEndPoint.dx,firstEndPoint.dy);
      
      path.quadraticBezierTo(secondControlPoint.dx,secondControlPoint.dy,
                              secondEndPoint.dx,secondEndPoint.dy);

      path.lineTo(size.width,size.height-20); // final end point
      path.lineTo(size.width,0.0);
       
    path.close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;

}

class OneSideClip extends CustomClipper<Path>{

  @override
  Path getClip(Size size){

    //var firstEndPoint= Offset(0.0,size.height/2);
    var firstControlPoint=Offset(size.width/2,size.height); //this means the curved point
    var firstEndPoint=Offset(size.width,size.height);// end of curve
   
    var path= new Path();
      path.lineTo(0.0,size.height/4);
      //draw your curve in betweeen this two point

      path.quadraticBezierTo(firstControlPoint.dx,firstControlPoint.dy,
                             firstEndPoint.dx,firstEndPoint.dy);
                             
      //path.lineTo(size.width,size.height-20); // final end point
      path.lineTo(size.width,0.0);
       
    path.close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;

}