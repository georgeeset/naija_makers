import 'dart:async';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:naija_makers/models/feed.dart';
import 'package:naija_makers/models/follower.dart';
import 'package:naija_makers/models/post.dart';

import '../constants.dart' as Constants;

class PostsProvider extends ChangeNotifier {
  FirebaseUser user;

  final Firestore _firestore = Firestore.instance;
  Geoflutterfire geoflutterfire = Geoflutterfire();

  updateUser(FirebaseUser newUser) {
    this.user = newUser;
    print('updateUser at postsProvider called');
  }

  List<Feed> myFeed;
  DocumentSnapshot _lastDocument;
  List<Post> _postList = List<Post>();
  bool _followingListExhausted = false;
  bool _alone = false;

  final int maxPerBatch = 2;

  // Future<void> addPost(Post post) async {
  //   _firestore
  //       .collection(Constants.posts)
  //       .document(user.uid)
  //       .collection(Constants.posts) // automatically generate unique post id
  //       .add(post.toMap);
  // }

//GeoFirePoint myLocation = geo.point(latitude: 12.960632, longitude: 77.641603);

//  _firestore
//         .collection('locations')
//         .add({'name': 'random name', 'position': myLocation.data});

/* in the background, this function queries through list of posts in the post collection
// *first level* and collate a list of uid's and other info to store in personall feed 
// collection for ease of access.*/

  // Stream<List<DocumentSnapshot>> feedFromLocation(GeoFirePoint point) {
  //   double radius = 50; // expand as you wish.
  //   String field = 'position';
  //   var collectionReference = _firestore.collection(Constants.posts);

  //   return geoflutterfire.collection(collectionRef: collectionReference).within(
  //         center: point,
  //         radius: radius,
  //         field: field,
  //       );
  // }

  //followings are people you are following.
  Future<void> callPosts() async {
    //print(user.uid);

    if (_followingListExhausted) {
      return;
    }

    if (_lastDocument == null) {
      final QuerySnapshot query = await _firestore
          .collection(Constants.followers)
          .document(user.uid)
          .collection(Constants
              .following) //.add({'date':DateTime.now().millisecondsSinceEpoch,'uid':'hfhfhfhfhfhhfhfhffh'});
          .orderBy(Constants.date, descending: false)
          .limit(maxPerBatch)
          .getDocuments();

      if (query.documents.isEmpty) {
        _followingListExhausted = true;
        return;
      }
      if (maxPerBatch > query.documents.length) {
        _followingListExhausted = true;
      }
      _lastDocument = query.documents.last; // where to resume next batch.
      print('still have some more');

      List<Follower> group =
          query.documents.map((value) => Follower.fromMap(value.data)).toList();
//print(group);
      if (group.isNotEmpty) {
        getPost(group);
      } else {
        _alone = true;
        notifyListeners();
      }
    } else {
      final QuerySnapshot query = await _firestore
          .collection(Constants.followers)
          .document(user.uid)
          .collection(Constants.following)
          .orderBy(Constants.date, descending: false)
          .startAfterDocument(_lastDocument)
          .limit(maxPerBatch)
          .getDocuments(source: Source.serverAndCache);

      if (query.documents.isEmpty) {
        _followingListExhausted = true;
        return; // prevent null error if query is empty
      } else {
        if (maxPerBatch > query.documents.length) {
          _followingListExhausted = true;
        }
      }
      _lastDocument = query.documents.last; // where to resume next batch.
      print('i dont know how ...${query.documents.length}');

      List<Follower> group =
          query.documents.map((value) => Follower.fromMap(value.data)).toList();
      if (group.isNotEmpty) {
        getPost(group);
      }
    }
    return;
  }

  void getFeed() {} //not in use yet

  //String get testPoste => 'this is yrttryrty you get posts';

  void getPost(List<Follower> makers) async {
    // collate list of posts to be displayed. followers are sent in batches
    //print('finding Posts');
    makers.forEach((maker) {
      //print(maker.uid);
      _firestore
          .collection(Constants.posts)
          .document(maker.uid)
          .collection(Constants.posts)
          .orderBy(Constants.timeStamp, descending: true)
          .limit(8) //last 8 posts form same person
          .getDocuments()
          .then((snapshot) {
        //print(snapshot.documents.length);
        //  if(snapshot.documents.isEmpty){
        //    return;
        //  }
        _postList.addAll(snapshot.documents.map((post) {
          //print(post.documentID);
          return Post.fromMap(post);
        }).toList());

        notifyListeners();
      }).catchError((err) => print(err));
    });
  }

  Future<void> callRefresh() {
    print('previous list cleared');
    _alone = false;

    _postList.clear();
    _lastDocument = null;
    _followingListExhausted = false;
    notifyListeners();
    return callPosts();
    // return Future.delayed(
    //   Duration(seconds: 3),
    // );
  }

  void deletePost(String postId) {
    _firestore
        .collection(Constants.posts)
        .document(user.uid) // canonly delete own post
        .collection(Constants.posts)
        .document(postId)
        .delete();
  }

  void editPost(Post post) {
    _firestore
        .collection(Constants.posts)
        .document(user.uid) // canonly delete own post
        .collection(Constants.posts)
        .document(post.postId)
        .updateData(post.toMap);
  }

  List<Post> get posts => _postList;
  String get userId => user.uid;
  bool get listExhausted => _followingListExhausted;
  bool get isalone => _alone;
}
