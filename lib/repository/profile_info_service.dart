import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naija_makers/models/profile.dart';
import '../constants.dart' as Constants;

class ProfileInfoService{

  final Firestore _firestore=Firestore.instance; 


  Future<Profile> userInfo(uid)async{
    DocumentSnapshot documentSnapshot= await _firestore.collection(Constants.users).document(uid).get();
      return Profile.fromMap(documentSnapshot.data);
  }

  Future<int> followersCount(uid)async{
    DocumentSnapshot documentSnapshot= await _firestore.collection(Constants.followers).document(uid).get();
     
     try{
       return documentSnapshot.data['followers_count'];
       }catch(err){
         print(err);
         return 0;
        
       }
     
  }


}