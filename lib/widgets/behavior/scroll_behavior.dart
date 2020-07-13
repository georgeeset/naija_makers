import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior{

  @override 
  Widget buildViewpointChrome(
    BuildContext context, Widget child, AxisDirection axisDirection
  ){
    return child;
  }
}