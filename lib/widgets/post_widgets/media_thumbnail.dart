import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:naija_makers/widgets/post_widgets/close_button.dart';
import 'package:provider/provider.dart';

class MediaThumbnail extends StatelessWidget {
  final File image;
  final Function onClosed;
  final int index;
  MediaThumbnail({this.image, this.onClosed, @required this.index});
  @override
  Widget build(BuildContext context) {
    print('mediaThumbnail build');
    return Card(
      elevation: 3.0,
      child: Container(
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Hero(
                tag: index,
                child: Image.file(image, fit: BoxFit.contain),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: CloseThumbnailButton(onClosed: onClosed),
              ),
              Positioned(
                bottom: 0,
                child: Consumer<NewPostProvider>(
                    builder: (context, newPost, child) {
                  StorageUploadTask sut =
                      newPost.getMultiImageUploadTask(index);
                  return sut.isSuccessful
                      ? Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white60),
                          child: const Icon(Icons.check, color: Colors.green),
                        )
                      : sut.isInProgress
                          ? Container(
                              height: 3,
                              width: 150,
                              child: LinearProgressIndicator())
                          : IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () =>
                                  newPost.resendImage(index: index),
                            );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
