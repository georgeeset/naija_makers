import 'dart:async';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ManageImage {

  static Future<File> resizeImage({File image,int quality}) async {
    ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
    File compressedFile = await FlutterNativeImage.compressImage(
      image.path,
      quality: quality,
      targetWidth: 600,
      targetHeight: (properties.height * 600 / properties.width).round()
    );
    
    return compressedFile;
  
  }

}    