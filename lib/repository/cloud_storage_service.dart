import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {

  StorageUploadTask _uploadTask;
  FirebaseStorage _storage=FirebaseStorage.instance;

  StorageUploadTask startUpload({
    @required File file,//file to be uploaded
    @required String filePath,//file location plus file name together
  }){
    return _storage.ref().child(filePath).putFile(file);
  }

 Stream <StorageTaskEvent> uploadTask(){
   return _uploadTask.events;
 }
  
}