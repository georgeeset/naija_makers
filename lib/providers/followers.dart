import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:naija_makers/models/follower.dart';

class FollowersProvider extends ChangeNotifier {
  FirebaseUser user;
  FollowersProvider({this.user}) {
    print(user.phoneNumber);
  }

  void updateUser(FirebaseUser newUser) {
    user = newUser;
  }

  final Firestore _firestore = Firestore.instance;

  Future<QuerySnapshot> get myFollowers async => await _firestore
      .collection('followers')
      .document(user.uid)
      .collection('followers')
      .getDocuments(source: Source.serverAndCache);

  Future<int> followersCount(userId) async  {
      QuerySnapshot snapshot=  await _firestore
      .collection('followers')
      .document(userId)
      .collection('followers')
      .getDocuments(source: Source.serverAndCache).catchError((err){
        throw err;});
      return snapshot.documents.length;
      }

  Future<QuerySnapshot> get followings async => await _firestore
      .collection('followings')
      .document(user.uid)
      .collection('followings')
      .getDocuments(source: Source.serverAndCache);

  Future<void> follow(
    Follower data,
  ) async {
    await _firestore
        .collection('followings')
        .document(user.uid)
        .collection('followers')
        .document(user.uid)
        .setData(data.toMap);
  }

}
