

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatelessWidget {
  final Function cameraAction;
  final File _image;

  ProfileAvatar(this.cameraAction,this._image);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundColor: Theme.of(context).primaryColor,
            child: ClipOval(
                child: Container(
              height: 155.0,
              width: 155.0,
              color: Colors.green,
              child: _image==null? Container() :Image.file(_image),
            )),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: IconButton(
              alignment: Alignment.bottomRight,
              icon: Icon(
                Icons.add_a_photo,
                color: Theme.of(context).primaryColor,

              ),
              onPressed: () {cameraAction(ImageSource.camera);},
            ),
          )
        ],
      ),
    );
  }
}
