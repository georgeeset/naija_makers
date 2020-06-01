import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowCachedNetworkImage extends StatelessWidget {
  final String imageLink;
  final double iconsize;

  ShowCachedNetworkImage({@required this.imageLink, @required this.iconsize});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:imageLink,
          child: CachedNetworkImage(
          imageUrl: imageLink,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(width:20,height:20, child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
                size: iconsize,
              )
              ),
    );
  }
}
