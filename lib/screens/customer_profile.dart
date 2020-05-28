import 'dart:io';

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
import '../widgets/profile_avatar.dart';

class CustomerProfile extends StatefulWidget {
  static const String routName = '/customer_profile';

  final bool isEditable;
  CustomerProfile({this.isEditable = false});

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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const double radius = 80;

    Profile profile =
        (ModalRoute.of(context).settings.arguments) ?? owner.userProfile;

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
                              fullImageLink:
                                  profile.profilePix),
              Container(
                height: 20,
              ),
              NameRow(data: profile.name,isEditable: widget.isEditable,editName: editName,),
          
               Divider(),

              Container(
                height: 20,
              ),
   EmailRow(isEditable: widget.isEditable, data: profile.email,editEmail: editEmail,),
              Container(
                height: 20,
              ),
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
    File pickedImage = await ImageGetter.getImage(ImageSource.camera);
    if (pickedImage != null) {
      print('image is selected');
      setState(() {
        isLoading = true;
      });

      await CropImage.getCroppedImage(pickedImage).then((cropped) {
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

  void editCoverPhotoClicked() async {
    owner.busy = true;
    int coverSize = 3048000; //2mb setpoint for now
    File pickedImage = await ImageGetter.getImage(ImageSource.gallery);

    if (pickedImage != null) {
      int filesize = await pickedImage.length();
      print(filesize);

      if (filesize > coverSize) {
        int compression = (((filesize - coverSize) / filesize) * 100).toInt();
        await ManageImage.resizeImage(image: pickedImage, quality: compression)
            .then((data) {
          owner.uploadCoverPhoto(data);
        });
      } else {
        owner.uploadCoverPhoto(pickedImage);
      }
    }
  }

  void editLogoClicked() async {
    owner.busy = true;
    print('logo edit clicked');
    File pickedImage = await ImageGetter.getImage(ImageSource.gallery);
    if (pickedImage != null) {
      await CropImage.getCroppedImage(pickedImage).then((image) async {
        if (image != null) {
          owner.uploadProfileLogo(image);
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