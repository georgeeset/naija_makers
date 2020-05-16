import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/screens/user_signup.dart';
import 'package:naija_makers/screens/user_type_selection.dart';
import 'package:naija_makers/widgets/login_widgets/login_ui.dart';
import 'package:provider/provider.dart';

import 'introduction.dart';


class LoginPage extends StatelessWidget {
  static const routName = '/login_page';
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (BuildContext context, ProfileProvider status, _) {
      switch(status.newUserStatus){
        case (NewUserStatus.introduction): return IntroductionPage();
        case (NewUserStatus.signup): return UserSignUpPage();
        case (NewUserStatus.userType): return UserTypeSelectionPage();

        default: return LoginUi();
      }
    },);
  }
}
