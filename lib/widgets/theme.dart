import 'package:flutter/material.dart';


enum MyThemeKeys { LIGHT, DARK, DARKER }

class AppTheme{

  AppTheme._();
  
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    fontFamily: 'Montserrat',
    accentColor: Colors.purple[600],

    iconTheme: IconThemeData(color: Colors.red),
    //accentIconTheme: IconThemeData(color: Colors.red[200]),
    //sliderTheme: SliderThemeData(activeTrackColor: Colors.purple,activeTickMarkColor: Colors.red),
    dividerTheme: DividerThemeData( color: Colors.green[200],space: 2,thickness: 1),
    dialogTheme: DialogTheme(contentTextStyle: TextStyle(fontSize: 10),titleTextStyle: TextStyle(fontSize: 14)),
    buttonTheme: ButtonThemeData(minWidth: 5),
    
    
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      subhead: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      title: TextStyle(fontSize: 30.0, fontStyle: FontStyle.normal,color: Colors.black),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      //body2: TextStyle(fontSize:19,fontFamily: 'TimeNewRoman'),
      button: TextStyle(color: Colors.white),
    ),

    appBarTheme: AppBarTheme(
      elevation: 0.5,
    ),

    //pageTransitionsTheme: PageTransitionsTheme(builders: {
      
   // })

  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',

     textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  static final ThemeData darkerTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',

     textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.DARKER:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }
    
}