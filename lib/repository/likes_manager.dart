import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naija_makers/models/like.dart';

import '../constants.dart' as Constants;


class LikesManager{
  
   final Firestore _firestore=Firestore.instance; 
  
   Future<bool> likeStatus(String posterUid, String postId,String uid) async {
    bool exists = await _firestore
        .collection(Constants.posts)
        .document(posterUid) // canonly delete own post
        .collection(Constants.posts)
        .document(postId)
        .collection(Constants.likes)
        .document(uid)
        .get().then((document)=>document.exists ? true : false);
    return exists;
   }

    
    void likePost(String posterUid, String postId,String uid) {
    Like like =
        Like(uid: uid, time: DateTime.now().millisecondsSinceEpoch);

    _firestore
        .collection(Constants.posts)
        .document(posterUid) // canonly delete own post
        .collection(Constants.posts)
        .document(postId)
        .updateData({Constants.likesCount: FieldValue.increment(1)});

    _firestore
        .collection(Constants.posts)
        .document(posterUid)
        .collection(Constants.posts)
        .document(postId)
        .collection(Constants.likes)
        .document(uid)
        .setData(like.toMap);
  }

  void unLikePost(String posterUid, String postId,String uid) {
    //increase like count

    _firestore
        .collection(Constants.posts)
        .document(posterUid) // canonly delete own post
        .collection(Constants.posts)
        .document(postId)
        .updateData(
            {Constants.likesCount: FieldValue.increment(-1)}); //I hope it works

    _firestore
        .collection(Constants.posts)
        .document(posterUid)
        .collection(Constants.posts)
        .document(postId)
        .collection(Constants.likes)
        .document(uid)
        .delete();
  }

}