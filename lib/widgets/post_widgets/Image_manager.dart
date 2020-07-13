import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:naija_makers/screens/image_preview.dart';
import 'package:provider/provider.dart';
import 'media_thumbnail.dart';

class ImageManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      width: size.width,
      child: Consumer<NewPostProvider>(builder: (contex, post, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: post.multiImage.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: MediaThumbnail(
                image: post.multiImage[index],
                onClosed: () => post.removeMedia(
                  index: index,
                ),
                index: index,
              ),
              onTap: () async => post.editImage(
                  image: await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewPage(
                          imageFile: post.multiImage[index],
                          heroTag: index,
                          isEditable: false),
                    ),
                  ),
                  index: index),
            );
          },
        );
      }),
    );
  }
}
