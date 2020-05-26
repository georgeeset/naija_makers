import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ImageShower extends StatelessWidget {
   final String imageLink;
   ImageShower({@required this.imageLink});
  @override
  Widget build(BuildContext context) {
 final MediaQueryData mediaQueryData=MediaQuery.of(context);
    return  Dialog(
        //insetAnimationDuration: Duration(milliseconds: 900),
        backgroundColor: Colors.transparent,
              child: Container(
width: mediaQueryData.size.height,
height: mediaQueryData.size.width,
                child: PhotoView(
           imageProvider: CachedNetworkImageProvider(imageLink,),
          // Contained = the smallest possible size to fit one dimension of the screen
          minScale: PhotoViewComputedScale.contained * 0.8,
          // Covered = the smallest possible size to fit the whole screen
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: false,
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent //Colors.black12,
          ),
          loadingBuilder: (context, imageChunkEvent){
           // double progress= imageChunkEvent==null? 0.0: ((imageChunkEvent.expectedTotalBytes-imageChunkEvent.cumulativeBytesLoaded)/imageChunkEvent.expectedTotalBytes)*100;
           return Center(child: Container(width:40,height:40,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)));//value:progress)));
          },
         heroAttributes: const PhotoViewHeroAttributes(tag:'image',),
          
    ),
              ),
    );

                //     return Dialog(
                //       backgroundColor: Colors.black12,
                //       child: CachedNetworkImage(
                //     imageUrl: imageLink,
                //     imageBuilder: (context, imageProvider) => PhotoView(
                //         imageProvider: imageProvider,
                //     ),
                //     placeholder: (context, url) =>
                //         CircularProgressIndicator(),
                //         errorWidget: (context, url, error) =>
                //             Icon(Icons.error),
                // ),
                //     );
   }
}