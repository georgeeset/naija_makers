import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:naija_makers/models/follower.dart';
import 'package:naija_makers/providers/user.dart';

class FollowersProvider extends ChangeNotifier {
  FirebaseUser user;
  ProfileProvider profile;
  // FollowersProvider({this.profile}) {
  //   print(user.phoneNumber);
  //   user=profile.user;
  // }

  void updateUser(FirebaseUser newUser) {
    user = newUser;//.user;
  }

  final Firestore _firestore = Firestore.instance;

  List<Follower>followersList;

  // void myFollowers async {

  // QuerySnapshot followersSnapphot= lastFriendDocument==null 
  //   ? await  _firestore
  //     .collection('followers')
  //     .document(user.uid)
  //     .collection('followers').orderBy('time')
  //     .limit(20).getDocuments()

      
  //   : await _firestore
  //     .collection('followers')
  //     .document(user.uid)
  //     .collection('followers')
  //     .orderBy('time')
  //     .startAfterDocument(lastFriendDocument)
  //     .limit(20).getDocuments();

  //   lastFriendDocument=followersSnapphot.documents.last;
  //   return followersSnapphot.documents.map(
  //     (follower)=>Follower.fromMap(follower.data)
  //   ).toList();
      

//}

String get getFriendsTest=>'test firnds provider connection';

 void updateFollowersList(){
    _firestore
    .collection('followers')
    .document(user.uid)
    .collection('followers').orderBy('time')
    .getDocuments().then((snapshot){
      followersList.addAll(snapshot.documents.map(
        (follower)=>Follower.fromMap(follower.data)
      ).toList());
      notifyListeners();
    });
 }

//get follower count of anybody after providing the uid
  Future<int> followersCount(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('followers')
        .document(userId)
        .collection('followers')
        .getDocuments(source: Source.serverAndCache)
        .catchError((err) {
      throw err;
    });
    return snapshot.documents.length;
  }



  // Add someone to your follwings list. (follow somebody) and
  // Add your info to the persons followers list.. so you can easily find each other;
  
  Future<void> follow({
    Follower userData,
    Follower followingData,
    String masterUid,
  }) async {
    await _firestore
        .collection('followers')
        .document(user.uid)
        .collection('followings')
        .document(
            masterUid) //interchanged uid as document id so as to easily get data without querry
        .setData(followingData.toMap)
        .then((value) async => await _firestore
            .collection('followers')
            .document(masterUid)
            .collection('followers')
            .document(user.uid)
            .setData(userData.toMap));
  }

  // stop following someone and remove them from following list
  Future<void> unFollow({
    String masterUid,
  }) async {
    await _firestore
        .collection('followers')
        .document(user.uid)
        .collection('followings')
        .document(masterUid)
        .delete() // done deleting the person i am following from my list
        .then((value) async => await _firestore
            .collection('followers')
            .document(masterUid)
            .collection('followings')
            .document(user.uid)
            .delete()); // also deleted from the person i am folling. all disconnected
  }
}
