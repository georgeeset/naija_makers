import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/route/fade_scale_route.dart';
import 'package:naija_makers/widgets/show_cached_image.dart';

import '../screens/image_shower.dart';

class OnlineAvatar extends StatelessWidget {
  final bool editable;
  final double radius;
  final Color ringColor;
  final String imageLink;
  final Function editClicked;
  final String fullImageLink;
  final bool enableEnlarge;
  final String heroTag;

  OnlineAvatar(
      {this.editable = false,
      @required this.radius,
      this.ringColor = Colors.purple,
      @required this.imageLink,
      this.editClicked,
      this.fullImageLink,
      this.enableEnlarge = true,
      @required this.heroTag});

  @override
  Widget build(BuildContext context) {
    print('online avatar build');
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (imageLink != null || imageLink != '' && enableEnlarge) {
              Navigator.push(
                context,
                FadeScaleRoute(
                    page: ImageShower(
                        imageLink: fullImageLink ?? imageLink, hero: heroTag)),
              );
            } else {
              print('clicked');
              if (editable) {
                editClicked();
              }
            }
          },
          //splashColor: Theme.of(context).accentColor,
          child: Hero(
            tag: heroTag,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: ringColor,
              child: ClipOval(
                child: Container(
                  height: radius * 1.90,
                  width: radius * 1.90,
                  color: Colors.green,
                  child: imageLink == null
                      ? AssetImage('assets/images/person.png')
                      : ShowCachedNetworkImage(
                          imageLink: imageLink,
                          iconSize: radius,
                        ),
                ),
              ),
            ),
          ),
        ),
        editable == true
            ? Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  child: IconButton(
                    //alignment: Alignment.bottomRight,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      editClicked();
                    },
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black38,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
