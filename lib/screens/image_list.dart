import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/positioned_back_button.dart';
import 'package:naija_makers/widgets/show_cached_image.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'image_shower.dart';

class ImageListPage extends StatelessWidget {
  final int imageIndexTapped;
  final List<String> images;
  ImageListPage({this.imageIndexTapped, this.images});
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    if (imageIndexTapped != null && images.length > 1) {
      Future.delayed(
          Duration(milliseconds: 500),
          () => itemScrollController.scrollTo(
              index: imageIndexTapped,
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic));
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: <Widget>[
              images.length == 1
                  ? Center(
                      child: _ImageListItem(image: images[0]),
                    )
                  : Container(
                      child: ScrollablePositionedList.builder(
                          itemScrollController: itemScrollController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return _ImageListItem(image: images[index]);
                          })),
              PositionedBackButton(),
            ],
          ),
        ));
  }
}

class _ImageListItem extends StatelessWidget {
  const _ImageListItem({
    Key key,
    @required this.image,
    this.index = 0,
  }) : super(key: key);

  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => (ImageShower(
                    imageLink: image,
                    hero: image,
                  )))),
          child: Container(
            child: Hero(
              tag: image,
              child: ShowCachedNetworkImage(
                iconSize: 40,
                imageLink: image,
              ),
            ),
          )),
    );
  }
}
