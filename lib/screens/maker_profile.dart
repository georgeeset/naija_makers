import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/repository/crop_image.dart';
import 'package:naija_makers/repository/image_getter.dart';
import 'package:naija_makers/repository/manage_image.dart';
import 'package:naija_makers/widgets/cover_photo.dart';
import 'package:naija_makers/widgets/edit_pen.dart';
import 'package:naija_makers/screens/image_shower.dart';
import 'package:naija_makers/widgets/online_avatar.dart';
import 'package:naija_makers/widgets/profile_properties/email_row.dart';
import 'package:naija_makers/widgets/profile_properties/name_row.dart';
import 'package:naija_makers/widgets/profile_widgets/more_details.dart';
import 'package:naija_makers/widgets/route/fade_scale_route.dart';
import 'package:naija_makers/widgets/signup_widgets/business_address_field.dart';
import 'package:naija_makers/widgets/signup_widgets/business_info_field.dart';
import 'package:naija_makers/widgets/signup_widgets/business_name_field.dart';
import 'package:provider/provider.dart';

class MakerProfilePage extends StatefulWidget {
  static const routName = '/maker_profile';
  final bool isEditable;
  final Profile profile;
  MakerProfilePage({this.isEditable = false, this.profile});

  @override
  _MakerProfilePageState createState() => _MakerProfilePageState();
}

class _MakerProfilePageState extends State<MakerProfilePage> {
  var owner;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    owner = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print('maker Profile build');
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const double radius = 80; // determines the positions of the circle avatar

    final Profile profile =
        widget.isEditable ? owner.userProfile : widget.profile;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AbsorbPointer(
        absorbing: isLoading,
        child: Container(
          height: mediaQueryData.size.height,
          //padding: EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    CoverPhoto(profile.coverPhoto),
                    widget.isEditable
                        ? Positioned(
                            top: 30,
                            left: 10,
                            child: EditPen(editCoverPhotoClicked))
                        : Container(),
                    Positioned(
                      bottom: radius / 2,
                      left: (mediaQueryData.size.width / 2) - radius,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OnlineAvatar(
                              editable: widget.isEditable,
                              editClicked: editProfilePicture,
                              radius: radius,
                              ringColor: Theme.of(context).primaryColor,
                              imageLink: profile.profilePixThumb,
                              fullImageLink: profile.profilePix,
                              heroTag:
                                  profile.profilePixThumb), // size height 190
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    NameRow(
                      data: profile.name,
                      editName: editName,
                      isEditable: widget.isEditable,
                    ),
                    // myContainer(),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Business name:',
                              ),
                              Container(
                                width: mediaQueryData.size.width * .80,
                                child: Text(
                                  profile.businessName,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ],
                          ),
                          widget.isEditable
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.mode_edit,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor:
                                                Colors.lightGreen[300],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                                height:
                                                    mediaQueryData.size.height /
                                                        4,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      BusinessNameField(
                                                          editBusinessName,
                                                          'Business name'),
                                                      //RaisedButton(child:Text('ok'),onPressed:(){Navigator.pop(context);},)
                                                    ],
                                                  ),
                                                )),
                                          );
                                        });
                                  },
                                )
                              : Container(),
                        ]),

                    Divider(),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Business address:',
                              ),
                              Container(
                                width: mediaQueryData.size.width * .80,
                                child: Text(
                                  profile.businessAddress,
                                  style: Theme.of(context).textTheme.headline6,
                                  softWrap: true,
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                          widget.isEditable
                              ? IconButton(
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor:
                                                Colors.lightGreen[300],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                                height:
                                                    mediaQueryData.size.height /
                                                        4,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      BusinessAddressField(
                                                          editBusinessAddress,
                                                          'Business Address'),
                                                      //RaisedButton(child:Text('ok'),onPressed:(){Navigator.pop(context);},)
                                                    ],
                                                  ),
                                                )),
                                          );
                                        });
                                  },
                                )
                              : Container(),
                        ]),

                    Divider(),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Commitment level:',
                              ),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                reverseDuration: Duration(milliseconds: 400),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    alignment: Alignment.center,
                                    child: child,
                                  );
                                },
                                child: Text(
                                  profile.fullTime ? 'Full time' : 'Part time',
                                  style: Theme.of(context).textTheme.headline6,
                                  key: ValueKey<bool>(profile.fullTime),
                                ),
                              ),
                            ],
                          ),
                          widget.isEditable
                              ? Switch(
                                  value: profile.fullTime,
                                  onChanged: (val) {
                                    profile.fullTime = val;
                                    owner.updateProfile();
                                  },
                                )
                              : Container(),
                        ]),

                    Divider(),

                    EmailRow(
                      data: profile.email,
                      editEmail: editEmail,
                      isEditable: widget.isEditable,
                    ),
                    Divider(),
                    myContainer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (profile.businessLogo != '' &&
                                profile.businessLogo != null) {
                              Navigator.push(
                                  context,
                                  FadeScaleRoute(
                                      page: ImageShower(
                                    hero: profile.businessLogo,
                                    imageLink: profile.businessLogo,
                                  )));
                            }
                          },
                          child: Hero(
                            tag: profile.businessLogo,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: profile.businessLogo == null ||
                                        profile.businessLogo == ''
                                    ? null
                                    : DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          profile.businessLogo,
                                        ),
                                        //NetworkImage(profile.businessLogo),
                                        fit: BoxFit.contain,
                                      ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.green,
                              ),
                              child: widget.isEditable
                                  ? Align(
                                      alignment: Alignment.bottomRight,
                                      child: EditPen(editLogoClicked),
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          children: <Widget>[
                            Text(
                              'Job description',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SelectableText(
                              profile.description,
                              maxLines: null,
                            ),
                          ],
                        )),
                        widget.isEditable
                            ? IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor:
                                              Colors.lightGreen[300],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                              height:
                                                  mediaQueryData.size.height /
                                                      4,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    BusinessInfoField(
                                                        editDescription,
                                                        'Job description'),
                                                    //RaisedButton(child:Text('ok'),onPressed:(){Navigator.pop(context);},)
                                                  ],
                                                ),
                                              )),
                                        );
                                      });
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              myContainer(),
              Text(
                'Recent Posts',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              MoreDetails(
                isEditable: widget.isEditable,
                profile: profile,
                isMaker: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myContainer() {
    return Container(height: 10);
  }

  void editProfilePicture() async {
    print('image icon clicked');
    File pickedImage = await ImageGetter.getSelfie(ImageSource.camera);
    if (pickedImage != null) {
      print('image is selected');
      setState(() {
        isLoading = true;
        print('setState from editprfilePix');
      });

      await CropImage.getCroppedImage(image: pickedImage).then((cropped) {
        if (cropped != null) {
          print('image is cropped');
          ManageImage.resizeImage(image: cropped, quality: 30)
              .then((thumbnail) {
            print('resized');

            setState(() {
              isLoading = false;
              print('setState from getCropped image');
            });
            owner.uploadProfilePix(cropped, thumbnail);
          });
        }
      });
    }
  }

  void editCoverPhotoClicked() async {
    owner.busy = true;
    File pickedImage = await ImageGetter.getImage(ImageSource.gallery);
    File finalImage =
        await ManageImage.ratioResizeImage(pickedImage: pickedImage)
            .catchError((err) {
      SnackBar snackBar = SnackBar(
        content: Text('No file selected : $err'),
        // action: SnackBarAction(label: 'Undo', onPressed: () {
        // Some code to undo the change.
        //  },
        //),
      );

      Scaffold.of(context).showSnackBar(snackBar); // notify user of emptyFile
    });
    owner.uploadCoverPhoto(finalImage);
  }

  void editLogoClicked() async {
    owner.busy = true;
    print('logo edit clicked');
    File pickedImage = await ImageGetter.getImage(ImageSource.gallery);
    if (pickedImage != null) {
      await CropImage.getCroppedImage(image: pickedImage).then((image) async {
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

  void editBusinessAddress() {
    print('edit Business Address');
    owner.updateProfile();
  }

  void editDescription() {
    print('edit description');
    owner.updateProfile();
  }

  void editBusinessName() {
    print('edit Business name');
    owner.updateProfile();
  }
}
