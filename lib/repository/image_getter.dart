
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
      return null;
      
  }
}