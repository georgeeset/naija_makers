import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/repository/crop_image.dart';
import 'package:naija_makers/repository/image_getter.dart';
import 'package:naija_makers/repository/manage_image.dart';
import 'package:naija_makers/widgets/online_avatar.dart';
import 'package:naija_makers/widgets/profile_properties/email_row.dart';
import 'package:naija_makers/widgets/profile_properties/name_row.dart';
import 'package:provider/provider.dart';

class CustomerProfile extends StatefulWidget {
  static const String routName = '/customer_profile';

  final bool isEditable;
  final Profile profile;
  CustomerProfile({this.isEditable = false, this.profile});

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  var owner;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    owner = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 80;

    Profile profile = widget.isEditable ? owner.userProfile : widget.profile;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(6),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //     SizedBox(width:mediaQueryData.size.width, height: 3.0, child: LinearProgressIndicator()),

              OnlineAvatar(
                editable: widget.isEditable,
                editClicked: editProfilePicture,
                radius: radius,
                ringColor: Theme.of(context).accentColor,
                imageLink: profile.profilePixThumb,
                fullImageLink: profile.profilePix,
                heroTag: profile.profilePixThumb,
              ),
              Container(
                height: 20,
              ),
              NameRow(
                data: profile.name,
                isEditable: widget.isEditable,
                editName: editName,
              ),
              Divider(),
              Container(
                height: 20,
              ),
              EmailRow(
                isEditable: widget.isEditable,
                data: profile.email,
                editEmail: editEmail,
              ),
              Container(
                height: 20,
              ),

              widget.isEditable
                  ? Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Would you love to show your craft and your handy work?\n',
                              ),
                              TextSpan(text: 'You need an account upgrade to'),
                              TextSpan(
                                  text: ' maker\'s account. ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' Click Here ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      owner.newUserStatus =
                                          NewUserStatus.userType;
                                      owner.signOut();
                                    }),
                              TextSpan(
                                text: 'and Follow the instrucions',
                              ),
                            ]),
                        //textScaleFactor: 0.5,
                      ),
                    )
                  : Container(),
              Container(
                height: 20,
              ),

              Text(
                'Interests',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),

              //ToDo add profile of People he/she followes

              Container(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }

  void editProfilePicture() async {
    print('image icon clicked');
    File pickedImage = await ImageGetter.getSelfie(ImageSource.camera);
    if (pickedImage != null) {
      print('image is selected');
      setState(() {
        isLoading = true;
      });

      await CropImage.getCroppedImage(image: pickedImage).then((cropped) {
        if (cropped != null) {
          print('image is cropped');
          ManageImage.resizeImage(image: cropped, quality: 30)
              .then((thumbnail) {
            print('resized');

            setState(() {
              isLoading = false;
            });

            owner.uploadProfilePix(cropped, thumbnail);
          });
        }
      });
    }
  }

  void editName() {
    print('name Editing');
    owner.updateProfile();
  }

  void editEmail() {
    print('edit email');
    owner.updateProfile();
  }
}
