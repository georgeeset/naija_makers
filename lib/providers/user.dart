
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naija_makers/repository/cloud_storage_service.dart';
import 'package:naija_makers/repository/manage_image.dart';
import '../data/user_type.dart';
import '../models/profile.dart';
import '../data/db_locations.dart';


enum UploadState { Uploading, Done, Failed }
enum PhoneAuthStatus {TimeOut, CodeSent, AuthError, Idle}
enum NewUserStatus {introduction,userType,signup,login}

class ProfileProvider extends ChangeNotifier {

  int _verificationTimeout=120; //seconds
  String uid;
  bool _isLoggedin = false;
  String _verificationId;
  PhoneAuthStatus _phoneAuthStatus;
  double uploadProgress;
  bool _isLoading=false;
  File _awaitingProfilePix;
  NewUserStatus _newUserStatus= NewUserStatus.introduction;
  

  FirebaseUser _user; //= FirebaseAuth.instance.currentUser();
  FirebaseAuth _auth;
  Profile _userProfile;
  Firestore _firestore;
  StorageReference _storageReference;

  StorageUploadTask _uploadTask;


  ProfileProvider.instance() : _auth = FirebaseAuth.instance {
    _firestore=Firestore.instance;
    _storageReference=FirebaseStorage.instance.ref();
    _userProfile=Profile();
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    _user = firebaseUser;
    StreamSubscription<DocumentSnapshot> streamSub;
    if (_user != null) {
      _isLoggedin = true;
      notifyListeners();

      if(!_user.isAnonymous){

          CollectionReference reference=_firestore.collection('users');
          final String profilePixLocation='${DBLocations.profilePix + _user.uid}.jpg';
          final String profilePixThumbLocation='${DBLocations.profilePixThumb + _user.uid}.jpg';

          
          if(_awaitingProfilePix!=null){ //update saved info if user signedup recently
            final File compressed =await ManageImage.resizeImage(image: _awaitingProfilePix,quality:30);
            setProfile();
            
            await _uploadDoc(profilePixLocation,_awaitingProfilePix,).then(
              (link)async{ 
                  _userProfile.profilePix=link;
                  //notifyListeners();
                  print('profilePix uploaded');
                  updateProfile();

               }
            ).catchError((err){
                print('error uploading pix $err');
               // reference.document(_user.uid).setData(_userProfile.toMap);
            });

             await _uploadDoc(profilePixThumbLocation ,compressed).then(
                        (link){
                        _userProfile.profilePixThumb=link;
                        //notifyListeners();
                        updateProfile();
                        print ('thumbnail uploaded');
                      }
             ).catchError(
               (err){
                  print('error uploading pix $err');
               }
             );

            //print('new user');
            _awaitingProfilePix.delete();

          }else{
            streamSub = reference.document(_user.uid).snapshots().listen((snapshot) {
              //print(snapshot.data);
            _userProfile = Profile.fromMap(snapshot.data);
            notifyListeners();
            });
          }
      }

    } else {
      if (streamSub != null) {
        streamSub.cancel();
      }
      _isLoggedin=false;
      notifyListeners();
    }
  }

  Profile get userProfile => _userProfile;
  bool get loginStatus => _isLoggedin;
  PhoneAuthStatus get phoneAuthStatus => _phoneAuthStatus;
  bool get isAonimous=> _user==null? false :_user.isAnonymous;
  bool get isLoading=>_isLoading;
  int get codeTimeOut=>_verificationTimeout;
  NewUserStatus get newUserStatus=>_newUserStatus;
  StorageUploadTask get uploadTask=>_uploadTask;
  FirebaseUser get user=>_user;


  Future<void> verifyPhoneNumber(String _phone) async {
    _isLoading=true;
    notifyListeners();
    print(_phone);

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      _phoneAuthStatus=PhoneAuthStatus.Idle;
      notifyListeners();
      print('Verification completed');

      _isLoading=false;
      notifyListeners();
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
        _isLoading=false;
        notifyListeners();
        throw(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      _phoneAuthStatus = PhoneAuthStatus.CodeSent;
      notifyListeners();
      _isLoading=false;
      notifyListeners();
      _startTimer();
      print('codeSent');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      _phoneAuthStatus = PhoneAuthStatus.TimeOut;
      notifyListeners();
      print('auto retrieve timeout');
      //notifyListeners(); //ill make local timer for 50secs that will show on ui;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phone,
        timeout:
            const Duration(seconds:120), //time before another code can be sent
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout).timeout(Duration(seconds:20)).catchError((err){print(err);});
  }

  Future<bool> signInWithPhoneNumber(String _code) async {
    
    _isLoading=true;
    notifyListeners();

    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: _code,
      );
      await _auth.signInWithCredential(credential);
      _user = await _auth.currentUser();
      
       _isLoading=false;
      notifyListeners();
      _phoneAuthStatus=PhoneAuthStatus.Idle;
      notifyListeners();
      return true;

    } catch (e) {
      _isLoading=false;
      notifyListeners();
       throw (e);
      //print('failed');
    }

    // //assert(_user.uid == _user.uid);
    // if (!_user.isAnonymous) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<void> signupAnonymously() async {
    await _auth.signInAnonymously().then((result) {
      print('${result.user.uid}');
      notifyListeners();
    }).catchError((err) {
      Exception(err);
    });
  }

  Future signOut() async {
   _auth.signOut();
   _phoneAuthStatus=PhoneAuthStatus.Idle;
   notifyListeners();
  return Future.delayed(Duration.zero);
}

  _startTimer(){
    Timer.periodic(
                Duration(seconds: 1),
                    (Timer timer){
                      if(_verificationTimeout < 1){
                      timer.cancel();
                      _verificationTimeout=120;
                      notifyListeners();
                      }else{
                        _verificationTimeout = _verificationTimeout - 1;
                        notifyListeners();
                        }
                        
                      }
                    
              );
  }

  void userTypeSelected(UserType userType){
    print(userType);
    _userProfile.userType=userType; // set user type;
  }


  Future <String>_uploadDoc(String location, File document) async{
     StorageReference storageReference =_storageReference.child(location);
     StorageUploadTask uploadTask= storageReference.putFile(document);
      //return uploadTask;
    String downloadUrl= await (await uploadTask.onComplete).ref.getDownloadURL();
   // print(downloadUrl);
    return downloadUrl;
  }

 void uploadCoverPhoto(File image)async{
    String fileInfo='${DBLocations.coverPhoto + _user.uid}.jpg';
    CloudStorageService cloudStorageService=CloudStorageService();
    _uploadTask= cloudStorageService.startUpload(file: image,filePath: fileInfo);
    notifyListeners();
    await(await _uploadTask.onComplete).ref.getDownloadURL().then((downloadUrl){
      _userProfile.coverPhoto=downloadUrl;
      _uploadTask=null;
      notifyListeners();
      updateProfile();
    });
  }

  void uploadProfileLogo(File image)async{
    String fileInfo='${DBLocations.profileLogo + _user.uid}.jpg';
    CloudStorageService cloudStorageService=CloudStorageService();
    _uploadTask=cloudStorageService.startUpload(file: image,filePath: fileInfo);
    notifyListeners();
    await(await _uploadTask.onComplete).ref.getDownloadURL().then((downloadUrl){
      _userProfile.businessLogo=downloadUrl;
      notifyListeners();
    });
  }

  void uploadProfilePix(File fullImage,File compressedImage)async{
    String fileInfo='${DBLocations.profilePix + _user.uid}.jpg';
    String thumbinfo='${DBLocations.profilePixThumb + _user.uid}.jpg';
    CloudStorageService cloudStorageService=CloudStorageService();
    _uploadTask=cloudStorageService.startUpload(file: fullImage,filePath: fileInfo);
    notifyListeners();

    await(await _uploadTask.onComplete).ref.getDownloadURL().then((downloadUrl)async{
      _userProfile.profilePix=downloadUrl;
      notifyListeners();
      _uploadTask=cloudStorageService.startUpload(file: compressedImage,filePath:thumbinfo);
      notifyListeners();
      await(await _uploadTask.onComplete).ref.getDownloadURL().then((url){
        _userProfile.profilePixThumb=url;
        _uploadTask=null;
        notifyListeners();
        updateProfile();
       
      });

    });
  }

  void updateProfile(){
    CollectionReference reference=_firestore.collection('users');
    reference = _firestore.collection('users');
    reference.document(_user.uid).updateData(_userProfile.toMap);

  }
  
  void setProfile(){
    CollectionReference reference=_firestore.collection('users');
    reference = _firestore.collection('users');
    reference.document(_user.uid).setData(_userProfile.toMap);
  }

  set awaitigProfilePix(File pix){ // keep profile pix awaiting user signin
    _awaitingProfilePix=pix;
  }

  set newUserStatus(NewUserStatus stat){
    _newUserStatus=stat;
    notifyListeners();
  }

  set userProfile(Profile userProfile){
    _userProfile=userProfile;
    notifyListeners();
  }
  set busy(bool busy){

  }
}

