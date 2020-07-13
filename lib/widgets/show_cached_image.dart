import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowCachedNetworkImage extends StatelessWidget {
  final String imageLink;
  final double iconSize;
  final BoxFit fit;

  ShowCachedNetworkImage({
    @required this.imageLink,
    @required this.iconSize,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageLink,
        fit: fit,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => Icon(
              Icons.error_outline,
              size: iconSize,
            ));
  }
}
