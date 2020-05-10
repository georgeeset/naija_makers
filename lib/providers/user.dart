
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../assets/data/user_type.dart';
import '../models/profile.dart';


enum UploadState { Uploading, Done, Failed }
enum PhoneAuthStatus {TimeOut, CodeSent, AuthError, Idle}

class ProfileProvider extends ChangeNotifier {

  int _verificationTimeout=120; //seconds
  String uid;
  bool _isLoggedin = false;
  String _verificationId;
  PhoneAuthStatus _phoneAuthStatus;
  double uploadProgress;
  bool _isLoading=false;

  FirebaseUser _user; //= FirebaseAuth.instance.currentUser();
  FirebaseAuth _auth;
  Profile _userProfile;
  Firestore _firestore;

  ProfileProvider.instance() : _auth = FirebaseAuth.instance {
    _firestore=Firestore.instance;
    _userProfile=Profile();
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    _user = firebaseUser;
    
    StreamSubscription<DocumentSnapshot> streamSub;
    if (_user != null && !_user.isAnonymous) {
      CollectionReference reference = _firestore.collection('users');
      streamSub = reference.document(_user.uid).snapshots().listen((snapshot) {
        _userProfile = Profile.fromMap(snapshot.data);
      });
      
      _isLoggedin = true;
      notifyListeners();

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


  

  Future<void> verifyPhoneNumber(String _phone) async {
    _isLoading=true;
    notifyListeners();
    print(_phone);

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      _phoneAuthStatus=PhoneAuthStatus.Idle;
      notifyListeners();
      print('completed');

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
}

