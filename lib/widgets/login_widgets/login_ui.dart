import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:provider/provider.dart';

import '../login_clipper_path.dart';
import '../phone_input_field.dart';
import '../phone_verification_field.dart';

class LoginUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.green, //Theme.of(context).primaryColor,
                  //boxShadow: [BoxShadow(color: Colors.red, offset: Offset(10.0, 10.0))],
                ),
              ),
              clipper: GreenClip(),
            ),
            Positioned(
              top: mediaQueryData.size.height / 4.2,
              left: (mediaQueryData.size.width/2)-30,
              child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  // return profileProvider.isLoading
                  //     ? Transform.rotate(
                  //         angle: -pi / 11.7,
                  //         origin: Offset(0.0, 0.0),
                  //         child: Container(
                  //             width: mediaQueryData.size.width,
                  //             child: LinearProgressIndicator(),//valueColor: AlwaysStoppedAnimation<Color>(Colors.green),)
                  //             )
                  //       )
                  //     : Container();

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    child: Card(
                            elevation:3.0,
                            color: Colors.white,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          child: CircleAvatar(
                            radius: profileProvider.isLoading ? 30.0 :0.0,
                            child: CircularProgressIndicator(),
                          ),
                        )),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height / 3,
                child: Consumer<ProfileProvider>(
                  builder: (context, profile, child) {
                    return ListView(
                      children: <Widget>[
                        profile.phoneAuthStatus == PhoneAuthStatus.CodeSent
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Enter sms verification',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('You can resend code after.. '),
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 400),
                                        switchInCurve: Curves.easeInOutExpo,
                                        switchOutCurve: Curves.elasticInOut,
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return ScaleTransition(
                                            child: child,
                                            scale: animation,
                                          );
                                        },
                                        child: Text(
                                          '${profile.codeTimeOut}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.green),
                                          key: ValueKey<int>(
                                              profile.codeTimeOut),
                                        ),
                                      ),
                                      Text(' seconds')
                                    ],
                                  )
                                ],
                              )
                            : Text(
                                'Signin with phone',
                                style: TextStyle(fontSize: 20),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          switchInCurve: Curves.easeInOutExpo,
                          switchOutCurve: Curves.elasticInOut,
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              child: child,
                              scale: animation,
                            );
                          },
                          child: profile.phoneAuthStatus ==
                                  PhoneAuthStatus.CodeSent
                              ? PhoneVerificationField()
                              : PhoneInputField(),
                        ),
                        //PhoneInputField(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
