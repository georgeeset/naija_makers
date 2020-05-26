import 'dart:io';

import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';
import '../phone_input_field.dart';
import '../phone_verification_field.dart';
import '../login_clipper_path.dart';
import '../../data/signup_data.dart';
import '../profile_avatar.dart';
import 'business_address_field.dart';
import 'business_info_field.dart';
import 'business_name_field.dart';
import 'email_input_field.dart';
import 'name_input_field.dart';

class SignupFields extends StatefulWidget {
  final Function action;
  final Function cameraButton;
  final Map<String, dynamic> snapshot;
  final File _selectedFile;

  SignupFields(
      this.action, this.cameraButton, this._selectedFile, this.snapshot);

  @override
  _SignupFieldsState createState() => _SignupFieldsState();
}

class _SignupFieldsState extends State<SignupFields> {
  final Validate validate = Validate();
  //profile=Provider.of<ProfileProvider>(context ,listen:false);
  ProfileProvider profile;
  String errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile = Provider.of<ProfileProvider>(context, listen: false);
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
                      height: mediaQueryData.size.height / 2.5,
                      width: mediaQueryData.size.width,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // boxShadow: [BoxShadow(color: Colors.lightGreen,blurRadius: 25.0, spreadRadius: 5.0,offset: Offset(15,15,),),],
                      ),
                    ),
                  ),
                  widget.snapshot['inputType'] == InputType.selfie
                      ? Positioned(
                          top: 60,
                          right: 50,
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
                              profile.awaitigProfilePix = widget._selectedFile;
                              profile.newUserStatus = NewUserStatus.login;
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))
                        : SizedBox(
                            width: 140,
                            child: Text(
                              widget.snapshot['action'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            )),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 40),
                    child: Container(
                        color: Colors.black45,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Signup',
                          style: Theme.of(context)
                              .textTheme
                              .body2
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
          return NameInputField(widget.action, widget.snapshot['label']);
        }
      case (InputType.email):
        {
          return EmailInputField(widget.action, widget.snapshot['label']);
        }
      case (InputType.businessAddress):
        {
          return BusinessAddressField(widget.action, widget.snapshot['label']);
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
          return BusinessInfoField(widget.action, widget.snapshot['label']);
        }

      case (InputType.businessName):
        {
          return BusinessNameField(widget.action, widget.snapshot['label']);
        }

      default:
        {
          return (Container());
        }
    }
  }
}
