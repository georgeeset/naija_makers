import 'dart:io';

import 'package:flutter/material.dart';
import '../phone_input_field.dart';
import '../phone_verification_field.dart';
import '../login_clipper_path.dart';
import '../../assets/data/signup_data.dart';
import '../profile_avatar.dart';

class SignupFields extends StatelessWidget {
  final Function action;
  final Function cameraButton;
  final Map<String, dynamic> snapshot;
  final File _selectedFile;
  SignupFields(
      this.action, this.cameraButton, this._selectedFile, this.snapshot);
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

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
                  snapshot['inputType'] == InputType.selfie
                      ? Positioned(
                          top: 100,
                          left: 50,
                          child: ProfileAvatar(
                            cameraButton,
                            _selectedFile,
                          ),
                        )
                      : Container(),
                  Positioned(
                    bottom: 30,
                    left: 10,
                    child: (snapshot['inputType'] == InputType.selfie &&
                            _selectedFile != null)
                        ? RaisedButton(
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))
                        : SizedBox(
                            width: 140,
                            child: Text(
                              snapshot['action'],
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
            )
          ],
        ),
      ),
    );
  }

  Widget formField() {
    switch (snapshot['inputType']) {
      case (InputType.text):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onSubmitted: (vaue) => action(),
            decoration: InputDecoration(
              labelText: snapshot['label'],
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
            onSubmitted: (vaue) => action(),
            decoration: InputDecoration(
              labelText: snapshot['label'],
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
        case (InputType.textMultiLine):
        {
          return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSubmitted: (vaue) => action(),
            maxLines: null,
            decoration: InputDecoration(
              labelText: snapshot['label'],
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

      case (InputType.selfie):
        {
          return Container();
        }

      default:
        {
          return (Container());
        }
    }
  }
}