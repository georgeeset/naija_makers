

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:naija_makers/models/post.dart';

class PostsProvider with ChangeNotifier{
  FirebaseUser user;
  PostsProvider({this.user});

  final Firestore _firestore = Firestore.instance;

  
  PostsProvider.updateUser(FirebaseUser newUser){this.user=newUser;}

  void addPost(Post post) async {
      _firestore.collection('posts').document(user.uid).collection('post').add(post.toMap);
    }
    // QuerySnapshot get postsWithLocation{
    //   _firestore.collection('posts').where()
    // }
}