import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/show_cached_image.dart';

import 'image_shower.dart';

class OnlineAvatar extends StatelessWidget {
  final bool editable;
  final double radius;
  final Color ringColor;
  final String imageLink;
  final Function editClicked;
  final String fullImageLink;

  OnlineAvatar(
      {@required this.editable,
      @required this.radius,
      @required this.ringColor,
      @required this.imageLink,
      @required this.editClicked,
      @required this.fullImageLink});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (imageLink != null || imageLink != '') {
              // ImageShower(
              //   imageLink: imageLink,
              // );
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImageShower(imageLink: fullImageLink);
                  });
            } else {
              print('clicked');
              if (editable) {
                editClicked();
              }
            }
          },
          //splashColor: Theme.of(context).accentColor,
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
                        iconsize: radius,
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
