import 'dart:io';

import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/screens/login.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:naija_makers/widgets/home.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../phone_input_field.dart';
import '../phone_verification_field.dart';
import '../login_clipper_path.dart';
import '../../assets/data/signup_data.dart';
import '../profile_avatar.dart';

class SignupFields extends StatefulWidget {
  final Function action;
  final Function cameraButton;
  final Map<String, dynamic> snapshot;
  final File _selectedFile;

  SignupFields( this.action, this.cameraButton, this._selectedFile, this.snapshot);

  @override
  _SignupFieldsState createState() => _SignupFieldsState();
}

class _SignupFieldsState extends State<SignupFields> {
  final Validate validate=Validate();
  //profile=Provider.of<ProfileProvider>(context ,listen:false);
  ProfileProvider profile;
  String errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile=Provider.of<ProfileProvider>(context ,listen:false);
  }
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    //final profile=Provider.of<ProfileProvider>(context);
    return Container(
      // padding: EdgeInsets.only(left: 10,right: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                //alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  ClipPath(
                    clipBehavior: Clip.hardEdge,
                    clipper: OneSideClip(),
                    child: Container(
                      height: mediaQueryData.size.height,
                      width: mediaQueryData.size.width,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // boxShadow: [BoxShadow(color: Colors.lightGreen,blurRadius: 25.0, spreadRadius: 5.0,offset: Offset(15,15,),),],
                      ),
                    ),
                  ),
                  widget.snapshot['inputType'] == InputType.selfie
                      ? Positioned(
                          top: 100,
                          left: 50,
                          child: ProfileAvatar(
                            widget.cameraButton,
                            widget._selectedFile,
                          ),
                        )
                      : Container(),
                  Positioned(
                    bottom: 30,
                    left: 10,
                    child: (widget.snapshot['inputType'] == InputType.selfie &&
                            widget._selectedFile != null)
                        ? RaisedButton(
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if(widget._selectedFile!=null){
                                profile.setProfilePix(widget._selectedFile);
                                profile.newUserStatus=NewUserStatus.login;
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))
                        : SizedBox(
                            width: 140,
                            child: Text(
                              widget.snapshot['action'],
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            )),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child: Container(
                        color: Colors.black45,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Signup',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: formField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget formField() {
    switch (widget.snapshot['inputType']) {
      case (InputType.fullName):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateFullName(val);
              });
            },
            onSubmitted: (value) {
              if(errorText==null&&value!=null){
                profile.userProfile.name=value;
                widget.action();
                
              }else{print('done');}
            },
            decoration: InputDecoration(
              errorText: errorText,
              labelText: widget.snapshot['label'],
              labelStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              //fillColor: Colors.white,
            ),
          );
        }
      case (InputType.email):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateEmail(val);
              });
            },
            onSubmitted: (value){
              if(errorText==null){
                profile.userProfile.email=value;
                widget.action();
              }
            },
            decoration: InputDecoration(
              labelText: widget.snapshot['label'],
              errorText: errorText,
              labelStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.email,
              ),
              //fillColor: Colors.white,
            ),
          );
        }
         case (InputType.businessAddress):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateString(val);
              });
            },
            onSubmitted: (value){
              if(errorText==null){
                profile.userProfile.email=value;
                widget.action();
              }
            },
            decoration: InputDecoration(
              labelText: widget.snapshot['label'],
              errorText: errorText,
              labelStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.email,
              ),
              //fillColor: Colors.white,
            ),
          );
        }
      case (InputType.phone):
        {
          return PhoneInputField();
        }

      case (InputType.phoneVerification):
        {
          return PhoneVerificationField();
        }
        case (InputType.businessInfo):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateNote(val);
              });
            },
            onSubmitted: (value) {
              if(errorText==null){
                profile.userProfile.description =value;
                widget.action();
              }
            },
           // maxLines: 1,
            decoration: InputDecoration(
              labelText: widget.snapshot['label'],
              labelStyle: TextStyle(color: Colors.black54),
              errorText: errorText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.note,color: Colors.green,
              ),
              //fillColor: Colors.white,
            ),
          );
        }

         case (InputType.businessName):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateString(val);
              });
            },
             onSubmitted: (value) {
              if(errorText==null){
                profile.userProfile.businessName=value;
                widget.action();
              }
            },
            maxLines: null,
            decoration: InputDecoration(
              errorText: errorText,
              labelText: widget.snapshot['label'],
              labelStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.note,color: Colors.green,
              ),
              //fillColor: Colors.white,
            ),
          );
        }

      default:
        {
          return (Container());
        }
    }
  }
}