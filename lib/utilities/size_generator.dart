import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class Screen {
  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;
  //PIXELS

  static double diagonal(Size s) {
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(Size pxSize) {
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(Size size) => inches(size).width;
  static double heightInches(Size size) => inches(size).height;
  static double diagonalInches(Size size) => diagonal(size) / _ppi;

  static bool isLargePhone(Size size) => diagonal(size) > 720;
  static bool isTablet(Size size) => diagonalInches(size) >= 7;
  static bool isNarrow(Size size) => widthInches(size) < 3.5;
}

class SizeGenerator {
  static double getPostHeight(MediaQueryData mqd) {
    if (mqd.orientation == Orientation.landscape) {
      print('landScape');
      if (Screen.isLargePhone(mqd.size)) {
        print('large device');
        return mqd.size.width / 2;
      }
      if (Screen.isNarrow(mqd.size)) {
        print('narrow device');

        return mqd.size.width * 1.5;
      }
      print('tablet Size');
      return mqd.size.width * 2;
    }

    //if (mqd.orientation == Orientation.portrait) {}
    print('Portait allSize');
    return mqd.size.height / 2;
  }

  static double getPostWidth(MediaQueryData mqd) {
    if (mqd.orientation == Orientation.landscape) {
      print('landScape');

      if (Screen.isLargePhone(mqd.size)) {
        print('large device');

        return mqd.size.height * 1.5;
      }
      if (Screen.isNarrow(mqd.size)) {
        print('narrow device');

        return mqd.size.height * 2.5;
      }
      print('tablet Size');

      return mqd.size.height * 1.5;
    }

    //if (mqd.orientation == Orientation.portrait) {}
    print('Portait allSize');
    return mqd.size.width;
  }
}
