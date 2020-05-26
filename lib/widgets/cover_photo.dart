
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'image_shower.dart';

class CoverPhoto extends StatelessWidget {
  final String imageUrl;
  CoverPhoto(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return imageUrl==null || imageUrl==''
    ? Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.green,
                          ),
                        )
                        :InkWell(
                          onTap:(){
                             if (imageUrl != null || imageUrl != '') {
              

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImageShower(
                      imageLink: imageUrl,
                    );
                  });

                          }},
                                                  child: Hero(tag:'image',
                                                                                                      child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                      image: CachedNetworkImageProvider(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.green,
                            ),
                          ),
                                                  ),
                        )
                        ;
  }
}