import 'dart:io';
import 'package:naija_makers/data/media_type.dart';
import 'package:naija_makers/repository/cloud_storage_service.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:naija_makers/models/post.dart';
import 'package:naija_makers/repository/manage_image.dart';
import '../constants.dart' as constants;

//import 'package:shared_preferences/shared_preferences.dart';

class NewPostProvider extends ChangeNotifier {
  FirebaseUser user;
  Post _newMessage = Post(
    multiImage: [],
  );
  List<File> _multiImage = List<File>();
  List<StorageUploadTask> _multiImageUploadTask = List<StorageUploadTask>();
  StorageUploadTask _videoUploadTask;
  File _videoFile;
  // bool sendPost = false;
  // List<String> imagesUploaded = List<String>();

  final Firestore _firestore = Firestore.instance;
  //final SharedPreferences refData = await SharedPreferences.getInstance();
  //List<String>login=refData.getStringList('ref_data');

  updateUser(FirebaseUser newUser) {
    this.user = newUser;
    print('updateUser at NewPostProvider called');
  }

  // StorageUploadTask uploadImage(File file) {
  //   String filePix =
  //       '${DBLocations.postPix + user.uid}/${path.basename(file.path)}';
  //   CloudStorageService cloudStorageService = CloudStorageService();
  //   return cloudStorageService.startUpload(file: file, filePath: filePix);
  // }

  void activateMediaMode() {
    _newMessage.noBgColor = true;
    notifyListeners();
  }

  void addVideo({@required File media}) async {
    //only one video for now
    _newMessage.mediaType = MediaType.video; // inform everybody
    _videoFile = media; // store the file
    _uploadVideo(_videoFile); // start uploading
    _multiImage.clear(); // dont allow image and video upload at a time

    activateMediaMode();
  }

  void addImage({@required File image}) async {
    int currentIndex = _multiImage.length;
    _multiImage.add(await ManageImage.ratioResizeImage(pickedImage: image));
    _uploadImage(_multiImage[currentIndex]); // add it to multiImageUploadTak
    _newMessage.mediaType = MediaType.image;
    _videoFile = null; //make sure there is no video on the memory

    activateMediaMode();
  }

  void resendImage({int index}) {
    _retryImageUpload(index);
  }

  void removeVideo() {
    //print('is video? $isVideo');
    CloudStorageService csv = CloudStorageService();

    _newMessage.mediaType = MediaType.text; // inform everybody
    if (videoUploadTask.isComplete) {
      print('deleting uploadedFile');
      // delete the file
      csv.deleteFile(_newMessage.mediaUrl);
      _newMessage.mediaUrl = null; // remove the file and then remove the link
    } else {
      print('cancle uploading file');
      videoUploadTask.cancel();
    }
    _videoFile = null; // empty the file

    notifyListeners();
  }

  void removeImage({int index}) {
    CloudStorageService csv = CloudStorageService();

    if (_multiImageUploadTask[index].isSuccessful) {
      print('deleting uploadedFile');
      // delete the file
      csv.deleteFile(_newMessage.multiImage[index]);
      _newMessage.multiImage
          .removeAt(index); // remove the file and then remove the link

    } else {
      print('deleting uploading file');
      _multiImageUploadTask[index].cancel();
    }

    _multiImage.removeAt(index);
    _multiImageUploadTask.removeAt(index);
    if (_multiImage.length == 0) {
      // sendPost = false;
      _newMessage.mediaType = MediaType.text;
      _newMessage.noBgColor = true;
    }
    notifyListeners();
  }

  void editImage({File image, int index}) {
    if (image != null) {
      _multiImage[index] = image;
      notifyListeners();
    }
  }

  void prepareImage(File bigImage) async {
    File compressed = await ManageImage.ratioResizeImage(
        pickedImage: bigImage); // image size to be uploaded.
    _multiImage.add(compressed);
    //start uploadng if you like;
  }

  Future<void> sendSequence() async {
    //_multiImageUploadTask.forEach((task)=>task.)

    if (_newMessage.mediaType == MediaType.text) {
      if (_newMessage.messageText == null) {
        throw ('You have to tay something ...');
      }
      if (_newMessage.messageText.length < 10) {
        throw ('That message seems too short !');
      }

      print('Text good to upload text');
    }

    if (_newMessage.mediaType == MediaType.image) {
      if (_newMessage.multiImage != null) {
        if (_multiImage.length != _newMessage.multiImage.length) {
          //good to upload
          throw ('Not all files are uploaded');
        }
        print('Images good To Upload');
      }
    }

    if (_newMessage.mediaType == MediaType.video) {
      if (_newMessage.mediaUrl == null) {
        throw ('Video upload is not complete');
      }
      print('Video goodToUpload');
    }

    if (await _uploadPost()) {
      return;
    } else {
      throw ('Upload Failed');
    }
  }

  String get message => _newMessage.messageText;
  double get fontSize => _newMessage.fontSize;
  int get bgColor => _newMessage.bgColor;
  bool get noBgColor => _newMessage.noBgColor;
  MediaType get mediaType => _newMessage.mediaType;
  // bool get sendMedia => sendPost;
  StorageUploadTask get videoUploadTask => _videoUploadTask;
  List<File> get multiImage => _multiImage;
  String get mediaUrl => _newMessage.mediaUrl;
  File get videoFile => _videoFile;
  List<String> get multiImageLink => _newMessage.multiImage;

  StorageUploadTask getMultiImageUploadTask(int index) =>
      _multiImageUploadTask[index];

  bool wasUserDoingNothing() {
    if (_newMessage.messageText == null &&
        _newMessage.mediaType == MediaType.text) {
      return true;
    } else {
      return false;
    }
  }

  set message(String message) {
    if (_newMessage.messageText != message) {
      _newMessage.messageText = message;
      notifyListeners();
    }
  }

  // set bgColor(int color) {
  //   if(_newMessage.bgColor!=color){
  //     _newMessage.bgColor=color;
  //     notifyListeners();
  //   }
  // }

  set updateBgColor(int bgColor) {
    if (_newMessage.bgColor != bgColor) {
      _newMessage.bgColor = bgColor;
      _newMessage.noBgColor = false;
      notifyListeners();
    }
  }

  set updateNoBgColor(bool trueFalse) {
    if (trueFalse != _newMessage.noBgColor) {
      //_newMessage.mediaType= MediaType.text;
      //multiImage.clear();
      _newMessage.noBgColor = trueFalse;
      notifyListeners();
    }
  }

  void setFont(String value) {
    if (_newMessage.mediaType != MediaType.text) {
      if (_newMessage.fontSize != 16) {
        _newMessage.fontSize = 16;
        notifyListeners();
      }
      return;
    }

    int length = (value.length ~/ 30);
    switch (length) {
      case 0:
        {
          if (_newMessage.fontSize != 27) {
            _newMessage.fontSize = 27;
            notifyListeners();
          }
          break;
        }

      case 1:
        {
          if (_newMessage.fontSize != 25) {
            _newMessage.fontSize = 25;
            notifyListeners();
          }
          break;
        }

      case 2:
        {
          if (_newMessage.fontSize != 22) {
            _newMessage.fontSize = 22;
            notifyListeners();
          }
          break;
        }

      case 3:
        {
          if (_newMessage.fontSize != 20) {
            _newMessage.fontSize = 20;
            notifyListeners();
          }
          break;
        }

      case 4:
        {
          if (_newMessage.fontSize != 18) {
            _newMessage.fontSize = 18;
            notifyListeners();
          }
          break;
        }
      case 5:
        {
          if (_newMessage.fontSize != 15) {
            _newMessage.fontSize = 15;
            notifyListeners();
          }
          break;
        }
    }
  }

  void _uploadVideo(File media) async {
    CloudStorageService css = CloudStorageService();
    print(path.basename(media.path));

    _videoUploadTask = css.startUpload(
      file: media,
      filePath:
          '${constants.postVideoPath + user.uid}/${DateTime.now().millisecondsSinceEpoch.toString() + path.basename(media.path)}',
    );

    await (await _videoUploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((downloadUrl) {
      _newMessage.mediaUrl = downloadUrl;
    });

    notifyListeners();
  }

  void _uploadImage(File media) async {
    CloudStorageService css = CloudStorageService();
    print(path.basename(media.path));
    final int currentCount = _multiImageUploadTask.length;

    _multiImageUploadTask.add(css.startUpload(
      file: media,
      filePath:
          '${constants.postPicturesPath + user.uid}/${DateTime.now().millisecondsSinceEpoch.toString() + path.basename(media.path)}',
    ));

    await (await _multiImageUploadTask[currentCount].onComplete)
        .ref
        .getDownloadURL()
        .then((downloadUrl) {
      print(downloadUrl);
      _newMessage.multiImage.add(downloadUrl);
    });

    notifyListeners();
  }

  void _retryImageUpload(int index) async {
    CloudStorageService css = CloudStorageService();
    print(path.basename(multiImage[index].path));

    _multiImageUploadTask.add(css.startUpload(
      file: multiImage[index],
      filePath:
          '${constants.postPicturesPath + user.uid}/${DateTime.now().millisecondsSinceEpoch.toString() + path.basename(multiImage[index].path)}',
    ));

    await (await _multiImageUploadTask[index].onComplete)
        .ref
        .getDownloadURL()
        .then((downloadUrl) {
      print('Image retry uploaded');
      _newMessage.multiImage.insert(index, downloadUrl);
    });

    notifyListeners();
  }

  void eraseUploadsBeforeYouDie() {
    print('${_newMessage.mediaType}');
    if (_newMessage.mediaType == MediaType.video) {
      removeVideo();
    } else {
      if (_newMessage.mediaType == MediaType.image) {
        for (int index = 0; index < multiImage.length; index++) {
          removeImage(index: index);
        }
      }
    }
  }

  void _addAllBasicInfo() {
    _newMessage.posterUid = user.uid;
    _newMessage.likesCount = 0;
    _newMessage.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  Future<bool> _uploadPost() async {
    //Im not using the response
    _addAllBasicInfo();
    var result = await _firestore
        .collection('posts')
        .document(user.uid)
        .collection('posts')
        .add(_newMessage.toMap);
    if (result != null) return true;
    return false;
  }
}
