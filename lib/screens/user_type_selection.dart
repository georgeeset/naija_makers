import 'package:flutter/material.dart';
import 'package:naija_makers/assets/data/user_type.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/screens/user_signup.dart';
import 'package:provider/provider.dart';



class UserTypeSelectionPage extends StatelessWidget {
  static const String routName='user_type_selection_page';

  final List<Map<String, dynamic>>options=[
      {'title': 'I am a maker','note':'I want to showcase my skill and grow my business','userType':UserType.maker,},
      {'title': 'I am a client','note':'I am looking for something or someone who does it better','userType':UserType.client,},   
  ];


  @override
  Widget build(BuildContext context) {
    var profile=Provider.of<ProfileProvider>(context);
    MediaQueryData mediaQueryData= MediaQuery.of(context);
    return Scaffold(

      body: Container(
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        padding: EdgeInsets.all(5),
        child: Center(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (BuildContext context,int index){
              return Card(
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(color: Colors.white,width: 2.0)),
                          elevation: .5,   
                              child: InkWell(
                                onTap: (){
                                  //Navigator.of(context).pushReplacementNamed(LoginPage.routName, arguments:index);
                                  profile.userTypeSelected(options[index]['userType']); //update user type temprarily 
                                 //Navigator.of(context).pushReplacementNamed(UserSignUpPage.routName);
                                 profile.newUserStatus=NewUserStatus.signup;
                                },
                                splashColor: Theme.of(context).accentColor,
                                                              child: Container(
                  height: mediaQueryData.size.height*.45,
                  width: mediaQueryData.size.width,
                  //color: Colors.primaries[10+index],
                  color: Colors.green,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(options[index]['title'],style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,color:Colors.black),),
                      Container(height: 20,),
                      SizedBox(
                        width: mediaQueryData.size.width*.5, child: Text(options[index]['note'],textAlign: TextAlign.left,style: Theme.of(context).textTheme.body2.copyWith(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 18),),),
                  ],)
                 
                ),
                              ),
              );
            },
      ),
        ),),

    );
  }
}