import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/show_cached_image.dart';

class ImageCollage extends StatelessWidget {
  final List<String> multiImage;
  final double height;
  final double width;
  final Function onItemTapped;
  ImageCollage(
      {@required this.multiImage,
      @required this.height,
      @required this.width,
      @required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    double miniHeight = multiImage.length > 3 ? height / 3 : height / 2;

    return Container(
        width: width,
        height: height,
        child: multiImage.length == 1
            ? GestureDetector(
                onTap: () => onItemTapped(multiImage, 0, context),
                child: Hero(
                    tag: multiImage.first,
                    child: ShowCachedNetworkImage(
                      imageLink: multiImage.first,
                      iconSize: 40,
                      fit: BoxFit.cover,
                    )),
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    flex: multiImage.length == 2 ? 1 : 2,
                    child: Container(
                      //width: width / 2,
                      height: height,
                      padding: EdgeInsets.only(right: 1),
                      child: GestureDetector(
                        onTap: () => onItemTapped(multiImage, 0, context),
                        child: Hero(
                            tag: multiImage[0],
                            child: ShowCachedNetworkImage(
                                imageLink: multiImage[0],
                                iconSize: 40,
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        // width: width / 2,
                        height: height,
                        //padding: EdgeInsets.only(left: 2),
                        child: multiImage.length == 2
                            ? GestureDetector(
                                onTap: () =>
                                    onItemTapped(multiImage, 1, context),
                                child: Hero(
                                  tag: multiImage[1],
                                  child: ShowCachedNetworkImage(
                                      imageLink: multiImage[1],
                                      iconSize: 40,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // height: miniHeight,
                                      width: double.infinity, //width / 2,
                                      padding: EdgeInsets.all(1),
                                      child: GestureDetector(
                                        onTap: () => onItemTapped(
                                            multiImage, 1, context),
                                        child: Hero(
                                          tag: multiImage[1],
                                          child: ShowCachedNetworkImage(
                                            imageLink: multiImage[1],
                                            iconSize: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: miniHeight,
                                      width: double.infinity, //width / 2,
                                      padding: EdgeInsets.all(1),
                                      child: GestureDetector(
                                        onTap: () => onItemTapped(
                                            multiImage, 2, context),
                                        child: Hero(
                                          tag: multiImage[2],
                                          child: ShowCachedNetworkImage(
                                            imageLink: multiImage[2],
                                            iconSize: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  multiImage.length > 3
                                      ? Expanded(
                                          child: Container(
                                            // height: miniHeight,
                                            width:
                                                double.infinity, // width / 2,
                                            padding: EdgeInsets.all(1),
                                            child: Stack(children: <Widget>[
                                              Container(
                                                width: double
                                                    .infinity, // width / 2,
                                                child: GestureDetector(
                                                  onTap: () => onItemTapped(
                                                      multiImage, 3, context),
                                                  child: Hero(
                                                    tag: multiImage[3],
                                                    child:
                                                        ShowCachedNetworkImage(
                                                      ///display only index 3 image and
                                                      ///overlay the number of images left
                                                      ///undisplayed
                                                      imageLink: multiImage[3],
                                                      iconSize: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              multiImage.length > 4
                                                  ? Container(
                                                      width: double.infinity,
                                                      // width: width / 2,
                                                      height: miniHeight,
                                                      color: Colors.black45,
                                                      child: Center(
                                                        child: Text(
                                                            '+ ${multiImage.length - 4}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    )
                                                  : Container(),
                                            ]),
                                          ),
                                        )
                                      : Container(),
                                ],
                              )),
                  ),
                ],
              ));
  }
}
