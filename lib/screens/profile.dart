import 'package:flutter/material.dart';
import 'package:naija_makers/data/user_type.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/screens/customer_profile.dart';
import 'package:naija_makers/screens/maker_profile.dart';

// class ScreenArguments{
//   final String title;
//   final bool isMaker;

//   ScreenArguments({this.title, this.isMaker});
// }


class ProfilePage extends StatelessWidget {
  static final String routName='/profile_page';

  @override
  Widget build(BuildContext context) {

     final Profile args = ModalRoute.of(context).settings.arguments;
    

    return Scaffold(appBar: AppBar(title: Text(args.name),),
      body: args.userType==UserType.maker? MakerProfilePage(isEditable: false,profile:args):
            CustomerProfile(isEditable: false,profile:args),
    
    );
  }
}