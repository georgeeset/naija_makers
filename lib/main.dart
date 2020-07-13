
import 'package:flutter/material.dart';
import 'package:naija_makers/screens/user_signup.dart';
import 'package:provider/provider.dart';
import 'providers/user.dart';

import './widgets/theme.dart';
import './screens/update.dart';
import './screens/landing.dart';
import './screens/login.dart';
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
    print('main Build');
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create:(_)=>ProfileProvider.instance(),),
      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.getThemeFromKey(MyThemeKeys.LIGHT),
        
        initialRoute: '/',
        routes: <String,WidgetBuilder>{
          //MyHomePage.routName : (context)=> MyHomePage(),
          LandingPage.routName :(context)=> LandingPage(),
          LoginPage.routName :(context) => LoginPage(),
          //UpdatePage.routName:(context) => UpdatePage(),
          IntroductionPage.routName:(context)=>IntroductionPage(),
          UserTypeSelectionPage.routName:(context)=>UserTypeSelectionPage(),
          ProfilePage.routName:(context)=>ProfilePage(),
          UserSignUpPage.routName:(context)=>UserSignUpPage(),
          //ImageShower.routeName:(context)=>ImageShower(),
        },

        // onGenerateRoute: (settings){
        //   if(settings.name==ImageShower.routeName){
        //     return FadeScaleRoute(page: ImageShower());
        //   }
        //   else{
        //     return MaterialPageRoute(builder: (context)=>setting)
        //   }
        // },
         home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static final String routName='/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, ProfileProvider user, _){
      return user.loginStatus
      ? LandingPage()
      : LoginPage();
    },);
    // return LandingPage();
    //return LoginPage();
    //return UpdatePage();
    //return ProfilePage();
    //return UserSignUpPage();

  }
}
