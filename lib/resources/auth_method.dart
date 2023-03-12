
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_fullstack/resources/storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  Getting User Details 
  Future<model.User> getUserDetails()async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('user').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );
        // deleting existing data of "users" collection in firestore
        await _firestore.collection("users").doc("ExLX8imacpYRIYa90Yetm0vUqar2").delete();
        await _firestore.collection("users").doc("TYllk6ltXnd0WgT3xDPJRtNdCGH2").delete();
        // adding user in our database
        await _firestore
            .collection("user")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        
        await _firestore.collection("users").doc("ExLX8imacpYRIYa90Yetm0vUqar2").delete().then((doc) => print("Document deleted"),onError: (e) => print("Error updating document $e"),);
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
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
    
    
    catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

