import 'package:flutter/material.dart';
import 'package:instagram_fullstack/models/user.dart';
import 'package:instagram_fullstack/resources/auth_method.dart';
// 1.
class UserProvider with ChangeNotifier{
  // Declaring Global Variable '_user'
  User? _user;
  final AuthMethods _authMethods=AuthMethods();
  User get getUser => _user!;

// Whenever the data changes of user getting detalis from getUserDetails() we 
// update our global variable '_user' and also add Notify Listner to it 
  Future<void> refereshUser() async{
    User user =await _authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  } 
}