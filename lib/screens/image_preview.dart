import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends StatefulWidget {
  final File imageFile;
  final int heroTag;
  final bool isEditable;
  ImagePreviewPage(
      {@required this.imageFile, this.heroTag, this.isEditable = false});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  File imageFile;
  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PhotoView(
            imageProvider: FileImage(imageFile),
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: false,

            loadingBuilder: (context, imageChunkEvent) {
              // double progress= imageChunkEvent==null? 0.0: ((imageChunkEvent.expectedTotalBytes-imageChunkEvent.cumulativeBytesLoaded)/imageChunkEvent.expectedTotalBytes)*100;
              return Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ))); //value:progress)));
            },
            heroAttributes: PhotoViewHeroAttributes(
              tag: widget.heroTag ??
                  imageFile.length, // incase nobody gree bring tag
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )),
          ),
          widget.isEditable
              ? Positioned(
                  top: 40,
                  right: 20,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(imageFile),
                      )),
                )
              : Container(),
          widget.isEditable
              ? Positioned(
                  bottom: 40,
                  right: 20,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.crop,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            File selected = await ImageCropper.cropImage(
                                sourcePath: widget.imageFile.path,
                                cropStyle: CropStyle.rectangle,
                                androidUiSettings: AndroidUiSettings(
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  hideBottomControls: true,
                                  lockAspectRatio: false,
                                ));
                            if (selected != null) {
                              imageFile = selected;
                              setState(() {});
                            }
                          })),
                )
              : Container(),
        ],
      ),
    );
  }
}
