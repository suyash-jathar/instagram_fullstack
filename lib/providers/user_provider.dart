import 'package:flutter/material.dart';
import 'package:instagram_fullstack/resources/auth_method.dart';
import '../models/user.dart';
class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods=AuthMethods();
  Future<void> refreshUser() async{
    User user=await _authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  } 
  User get getUser => _user!; 
}