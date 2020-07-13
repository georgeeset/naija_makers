import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naija_makers/data/media_type.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:naija_makers/repository/image_getter.dart';
import 'package:naija_makers/screens/image_preview.dart';
import 'package:naija_makers/widgets/post_widgets/upload_menu.dart';
import 'package:provider/provider.dart';
import 'color_picker_card.dart';

class BackgroundPicker extends StatefulWidget {
  @override
  _BackgroundPickerState createState() => _BackgroundPickerState();
}

class _BackgroundPickerState extends State<BackgroundPicker> {
  final List<Map<String, dynamic>> uploadMenuItems = [
    {'title': 'Upload photo', 'icon': Icons.photo},
    {'title': 'Snap with camera', 'icon': Icons.camera},
    {'title': 'Upload video', 'icon': Icons.video_library},
    {'title': 'Record with video camera', 'icon': Icons.videocam},
  ];
  List<Map<String, dynamic>> mediaRelatedMenu = [];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      height: 30,
      width: mediaQuery.size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ColorPickerCard(
            whiteColor: true,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Consumer<NewPostProvider>(
              builder: (context, msgType, child) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  reverseDuration: Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SizeTransition(
                      axis: Axis.horizontal,
                      child: child,
                      sizeFactor: animation,
                      axisAlignment: 1.0,
                    );
                  },
                  child: msgType.mediaType == MediaType.text
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 16,
                          itemBuilder: (BuildContext context, int index) {
                            return ColorPickerCard(colorIndex: index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 2,
                            );
                          },
                        )
                      : Container(),
                );
              },
            ),
          )

              // ),
              ),
          Consumer<NewPostProvider>(builder: (context, newPost, child) {
            switch (newPost.mediaType) {
              case MediaType.image:
                mediaRelatedMenu = [uploadMenuItems[0], uploadMenuItems[1]];
                break;

              case MediaType.video:
                mediaRelatedMenu = [uploadMenuItems[2], uploadMenuItems[3]];
                break;

              default:
                mediaRelatedMenu = uploadMenuItems;
            }
            return RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                //do not allow upload if the user already uploaded 1video or 4 images
                newPost.multiImage.length > 3 ||
                        newPost.mediaType == MediaType.video
                    ? Icons.do_not_disturb_alt
                    : Icons.attach_file,
                color: Colors.white,
              ),
              onPressed: () => newPost.multiImage.length > 3 ||
                      newPost.mediaType == MediaType.video
                  ? null
                  : uploadButtonTapped(
                      context), //command modalBottom sheet now now
            );
          })
        ],
      ),
    );
  }

  void uploadButtonTapped(BuildContext context) async {
    File image;

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    int choice = await showModalBottomSheet(
        context: context,
        elevation: 2,
        enableDrag: true,
        builder: (_) {
          return UploadMenu(
            uploadMenuItems: mediaRelatedMenu,
          );
        });

    //print(choice);

    switch (choice) {
      case 0:
        {
          image = await ImageGetter.getImage(
              ImageSource.gallery); //.catchError((err)=>print(err)) ;
          break;
        }
      case 1:
        {
          image = await ImageGetter.getImage(
              ImageSource.camera); //.catchError((err)=>print(err));
          break;
        }

      case 2:
        {
          image = await ImageGetter.getVideo(
              ImageSource.gallery); //.catchError((err)=>print(err));
          break;
        }

      case 3:
        {
          image = await ImageGetter.getVideo(
              ImageSource.camera); //.catchError((err)=>print(err));
          break;
        }
    }
    if (image != null) {
      File selected;
      if (choice < 2) {
        selected = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
            imageFile: image,
            isEditable: true,
          ),
        ));
      } else {
        selected = image;
      } // it is a video and no need for preview page yet

      if (selected != null) {
        choice < 2
            ? Provider.of<NewPostProvider>(context, listen: false)
                .addImage(image: selected)
            : Provider.of<NewPostProvider>(context, listen: false)
                .addVideo(media: selected);
        // see wayo lol
      }
    }
  }
}
