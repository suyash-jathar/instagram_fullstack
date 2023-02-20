import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Fn for adding image in firebase Storage 
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost) async {
    Reference ref=_storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask=ref.putData(file);

    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}