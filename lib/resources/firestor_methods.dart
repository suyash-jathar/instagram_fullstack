import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = 'Some Error Occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'Sucees';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId,String uid, List likes) async{
    try{
      if(likes.contains(uid)){
        // In below if we used set then we have to pass 
        // every value so we used update so we can update one value 
        _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid])
        });
        // Above we are removing uid from 'like' array so that 
        // when somenone want to take his/her like back will get remove from 'like' array 
      }
      else{
        _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid])
        });
      }
    }
    catch(e){
      print(e.toString());
    }
  }


}
