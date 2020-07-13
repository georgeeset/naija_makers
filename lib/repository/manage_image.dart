import 'dart:async';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ManageImage {
  static Future<File> resizeImage({File image, int quality}) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(image.path);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: quality,
        targetWidth: 600,
        targetHeight: (properties.height * 600 / properties.width).round());

    return compressedFile;
  }

  static Future<File> ratioResizeImage(
      {File pickedImage, int fileSize = 319200}) async {
    //int coverSize = 819200; //300kb setpoint for now

    if (pickedImage != null) {
      int filesize = await pickedImage.length();
      print('original size $filesize');

      if (filesize > fileSize) {
        int compression = 90 - ((filesize) ~/ (filesize - fileSize));
        print('compression Quality $compression');
        File data = await resizeImage(image: pickedImage, quality: compression);
        print('compressed size ${await data.length()}');
        return data;
      } else {
        return pickedImage;
      }
    } else {
      print('ManageImage file empty');
      throw ('Empty File was sent to manageImage');
      //return pickedImage;
    }
  }
}
