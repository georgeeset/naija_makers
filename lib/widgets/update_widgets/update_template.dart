import 'package:flutter/material.dart';
import 'package:naija_makers/data/media_type.dart';
import 'package:naija_makers/models/post.dart';
import 'package:naija_makers/screens/image_list.dart';
import 'package:naija_makers/utilities/size_generator.dart';
import 'package:naija_makers/widgets/poster_info.dart';
import 'decorated_text.dart';
import 'image_collage.dart';
import 'update_actions.dart';
import 'update_text.dart';

class UpdateTemplate extends StatelessWidget {
  final Post data;
  UpdateTemplate({this.data});
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    //print(data.mediaUrl);
    return Container(
      //elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(
              2,
              2,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            PosterInfo(
              posterId: data.posterUid,
              timeStamp: data.timeStamp,
              postId: data.postId,
            ),

            Container(
              width: mediaQueryData.size.width,
              padding: data.noBgColor
                  ? const EdgeInsets.symmetric(horizontal: 8.0)
                  : EdgeInsets.only(top: 8.0),
              child: Center(
                child: data.noBgColor == true
                    ? data.messageText == null
                        ? Container()
                        : UpdateText(
                            text: data.messageText,
                          )
                    : DecoratedText(
                        text: data.messageText,
                        colorIndex: data.bgColor,
                        font: data.fontSize,
                      ),
              ),
            ),
            //optional container if only one picture is uploaded.
            data.mediaType == MediaType.image
                ? Container(
                    //height: SizeGenerator.getPostHeight(mediaQueryData),
                    // width: SizeGenerator.getPostWidth(mediaQueryData,),

                    child: ImageCollage(
                      multiImage: data.multiImage,
                      height: SizeGenerator.getPostHeight(mediaQueryData),
                      width: SizeGenerator.getPostWidth(mediaQueryData),
                      onItemTapped: imageTapped,
                    ),
                    // child: StaggeredGridView.countBuilder(
                    //   crossAxisCount: 4,
                    //   itemCount: data.multiImage.length,
                    //   itemBuilder: (BuildContext context, int index) =>
                    //       Container(
                    //     width: mediaQueryData.size.width,
                    //     child: CachedNetworkImage(
                    //         imageUrl: data.multiImage[index],
                    //         fit: BoxFit.cover,
                    //         progressIndicatorBuilder:
                    //             (context, url, downloadProgress) =>
                    //                 CircularProgressIndicator(
                    //                     value: downloadProgress.progress),
                    //         errorWidget: (context, url, error) => Icon(
                    //               Icons.error_outline,
                    //               size: 40,
                    //             )),
                    //   ),
                    //   staggeredTileBuilder: (int index) => StaggeredTile.fit(3),
                    //   mainAxisSpacing: 4.0,
                    //   crossAxisSpacing: 4.0,
                    // ),

                    // child: Wrap(
                    //   alignment: WrapAlignment.center,
                    //   direction: Axis.horizontal,
                    //   children: data.multiImage.map((image) {
                    //     return CachedNetworkImage(
                    //         imageUrl: image,
                    //         fit: BoxFit.fill,
                    //         progressIndicatorBuilder:
                    //             (context, url, downloadProgress) =>
                    //                 CircularProgressIndicator(
                    //                     value: downloadProgress.progress),
                    //         errorWidget: (context, url, error) => Icon(
                    //               Icons.error_outline,
                    //               size: 40,
                    //             ));
                    //   }).toList(),
                    // )
                  )
                : Container(),
            //optional listView.builder if picutes uploaded is many

            UpdateActions(
                postId: data.postId,
                posterUid: data.posterUid,
                likesCount: data.likesCount),
          ],
        ),
      ),
    );
  }

  // Widget textOnly(String text, Color bgColor, MediaQueryData mediaQueryData) {
  //   return Container(
  //     height: mediaQueryData.size.width,
  //     color: bgColor,
  //     child: Center(
  //       child: Text(text),
  //     ),
  //   );
  // }

  void imageTapped(List<String> images, int index, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ImageListPage(images: images, imageIndexTapped: index)));
  }
}
