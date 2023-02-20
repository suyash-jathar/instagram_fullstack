import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack/resources/storage_methods.dart';
import '../models/user.dart' as model ;

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance; 
  // Sign Up User Method
  Future<String> signUpUser(
    {
      required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file,
    }
  )async{
    String res="Some Error occured";
    try{
      if(email.isNotEmpty|| password.isNotEmpty|| username.isNotEmpty|| bio.isNotEmpty)
      {
        // Registering User
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // Uploading Image to Firebase Storage
        String photoUrl=await StorageMethods().uploadImageToStorage('profile_pic',file,false);


        model.User user=model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );



        // Adding User to Database 
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res="Success";
      }
    }
    catch(err)
    {
      res=err.toString();
    }
    return res;
  }


  // Loging User Method
  Future<String> loginUser(
    {
      required String email,
      required String password,
    }) async
    {
    String res="Some Error occured";
    try{
      if(email.isNotEmpty|| password.isNotEmpty)
      {
        // Registering User
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res="Success";
      }
      else
      {
        res="Please Enter Email and Password";
      }
    } 

    // If You want to show error message on screen then use this code
      // on FirebaseAuthException catch(err)
      // {
      //   if(err.code=='user-not-found')
      //   {
      //     res="No user found for that email";
      //   }
      //   else if(err.code=='wrong-password')
      //   {
      //     res="Wrong Password";
      //   }
      // }
    catch(err)
    {
      res=err.toString();
    }
    return res;
  } 


}