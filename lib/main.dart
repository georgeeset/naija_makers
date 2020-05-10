
import 'package:flutter/material.dart';
import 'package:naija_makers/screens/user_signup.dart';
import 'package:provider/provider.dart';
import 'providers/user.dart';

import './widgets/theme.dart';
import './screens/update.dart';
import './screens/landing.dart';
import './screens/login.dart';
import './screens/maker_profile.dart';
import './screens/introduction.dart';
import './screens/user_type_selection.dart';
import 'screens/profile.dart';

void main(){
   WidgetsFlutterBinding.ensureInitialized();
   runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create:(_)=>ProfileProvider.instance(),),
      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.getThemeFromKey(MyThemeKeys.LIGHT),
       
        routes: <String,WidgetBuilder>{
          LandingPage.routName :(context)=> LandingPage(),
          LoginPage.routName :(context) => LoginPage(),
          UpdatePage.routName:(context) => UpdatePage(),
          IntroductionPage.routName:(context)=>IntroductionPage(),
          UserTypeSelectionPage.routName:(context)=>UserTypeSelectionPage(),
          ProfilePage.routName:(context)=>ProfilePage(),
          UserSignUpPage.routName:(context)=>UserSignUpPage(),
        },

         home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, ProfileProvider user, _){
      return user.loginStatus
      ? LandingPage()
      : IntroductionPage();
    },);
    // return LandingPage();
    //return LoginPage();
    //return UpdatePage();
    //return ProfilePage();
    //return UserSignUpPage();

  }
}
