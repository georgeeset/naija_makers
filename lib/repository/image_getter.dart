
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageGetter{
    ImageGetter();

  static Future <File> getImage(ImageSource source) async {
     
      final File image = await ImagePicker.pickImage(source: source);
      if(image != null){
          return image;
          //image.delete(recursive: false);
      } 
      //throw('no Image');
      print('no Image');
  }

   static Future <File> getSelfie(ImageSource source) async {
     
      final File selfie = await ImagePicker.pickImage(source: source,preferredCameraDevice: CameraDevice.front);
      if(selfie != null){
          return selfie;
          //image.delete(recursive: false);
      } 
      //throw('no selfie');
      print('no selfie');
  }

   static Future <File> getVideo(ImageSource source) async {
     
      final File video = await ImagePicker.pickVideo(source: source,maxDuration: Duration(minutes: 5),);
      if(video != null){
          return video;
          //image.delete(recursive: false);
      } 
      //throw('no Video');
      print('no video');
  }
}