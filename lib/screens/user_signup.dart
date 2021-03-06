import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naija_makers/repository/crop_image.dart';
import 'package:naija_makers/repository/image_getter.dart';
import '../data/user_type.dart';
import '../providers/user.dart';
import 'package:provider/provider.dart';

import '../widgets/signup_widgets/signup_fields.dart';
import '../data/signup_data.dart';

class UserSignUpPage extends StatefulWidget {
  static final String routName='/user-signup-page';
  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  PageController pageController;
  bool _inProcess=false;
  File _selectedFile;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final profile=Provider.of<ProfileProvider>(context,listen: false);
    final List<Map<String,dynamic>>formFields=profile.userProfile.userType==UserType.maker? MakerSignupData.signupData :UserSignupData.signupData;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },

          child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height / 2,
          child: AbsorbPointer(
            absorbing: _inProcess,
               child: PageView.builder(
              controller: pageController,
              itemCount: formFields.length,//profile.userProfile.userType==UserType.maker? MakerSignupData.signupData.length:UserSignupData.signupData.length,
              itemBuilder: (context,int index){
                return SignupFields(switchPage,getImage,_selectedFile ,formFields[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  switchPage() {
    //print('moving');
    pageController.nextPage(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 400),
    );
  }

  getImage(ImageSource source)async{
     this.setState((){
        _inProcess = true;
      });
     await ImageGetter.getSelfie(source)
     .then((value)async{
        if(value!=null){
          await CropImage.getCroppedImage(image:value).then(
            (value) {
              if(value!=null){
                this.setState((){
                  _inProcess = false;
                  _selectedFile = value;
                });
                
              }else{setState(() {
                _inProcess=false;
              });}
            }
          );
        }else{setState(() {
          _inProcess=false;
        });}

     });

     
  }

}
