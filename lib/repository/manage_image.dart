import 'dart:async';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ManageImage {

  static Future<File> resizeImage({File image,int width,int height}) async {
    //ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
    File compressedFile = await FlutterNativeImage.compressImage(
      image.path,
      quality: 30,
     targetWidth: width, 
     targetHeight: height,
    );
    return compressedFile;
  }



}