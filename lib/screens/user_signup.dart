import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/signup_widgets/signup_fields.dart';
import '../assets/data/signup_data.dart';

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
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

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
              itemCount: MakerSignupData.signupData.length,//UserSignupData.signupData.length,
              itemBuilder: (context,int index){
                return SignupFields(switchPage,getImage,_selectedFile ,MakerSignupData.signupData[index]);
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

  getImage(ImageSource source) async {
      this.setState((){
        _inProcess = true;
      });
      File image = await ImagePicker.pickImage(source: source);
      if(image != null){
        File cropped = await ImageCropper.cropImage(
            sourcePath: image.path,
            aspectRatio: CropAspectRatio(
                ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.white,
              toolbarTitle: "Cropper",
              statusBarColor: Colors.green,
              backgroundColor: Colors.white,
            )
        );
        this.setState((){
          _selectedFile = cropped;
          _inProcess = false;
        });
      } else {
        this.setState((){
          _inProcess = false;
        });
      }
  }

}
