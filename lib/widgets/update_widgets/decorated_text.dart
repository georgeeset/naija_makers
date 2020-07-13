import 'package:flutter/material.dart';
import 'package:naija_makers/utilities/size_generator.dart';

class DecoratedText extends StatelessWidget {
  final String text;
  final int colorIndex;
  final double font;
  DecoratedText({this.text, this.colorIndex, this.font});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size size = mediaQueryData.size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.primaries[colorIndex],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
          image: const AssetImage('assets/images/bloom.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: SizeGenerator.getPostHeight(mediaQueryData), //250,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: font,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ),
    );
  }
}
