import 'package:flutter/material.dart';
import 'package:naija_makers/screens/customer_profile.dart';
import 'package:naija_makers/screens/maker_profile.dart';

class ScreenArguments{
  final String title;
  final bool isMaker;

  ScreenArguments({this.title, this.isMaker});
}


class ProfilePage extends StatelessWidget {
  static final String routName='/profile_page';

  @override
  Widget build(BuildContext context) {

     final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    

    return Scaffold(appBar: AppBar(title: Text(args.title),),
      body: args.isMaker? MakerProfilePage():
            CustomerProfile(),
    
    );
  }
}