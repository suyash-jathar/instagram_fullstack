// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_fullstack/resources/auth_method.dart';
import 'package:instagram_fullstack/screens/login_screen.dart';
import 'package:instagram_fullstack/utils/colors.dart';
import 'package:instagram_fullstack/utils/utils.dart';
import 'package:instagram_fullstack/widgets/text_input_field.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading=false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage()async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }
  void signUpUser() async
  {
    setState(() {
      _isLoading=true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!
    );

    setState(() {
      _isLoading=false;
    });

    if(res!='Success') {
      showSnackBar(context, res);
    }
    else{
       Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
            ),
        ),
      );
    }
    
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Container(),flex: 2,),
          SvgPicture.asset('assets/ic_instagram.svg',
              color: primaryColor, height: 64),
          SizedBox(
            height: 64,
          ),
          Stack(
            children: [
              _image!=null?CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
              ):
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg',
                ),
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () async{
                    selectImage();
                  },
                  icon: Icon(Icons.add_a_photo),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
      
          TextFieldInput(
            hintText: 'Enter Your Username',
            keyboardType: TextInputType.text,
            controller: _usernameController,
          ),
          const SizedBox(
            height: 24,
          ),
      
          // Text Field for Email and Password
          TextFieldInput(
            hintText: 'Enter Your Email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter Your Password',
            keyboardType: TextInputType.text,
            controller: _passwordController,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter Your Bio',
            keyboardType: TextInputType.text,
            controller: _bioController,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: signUpUser,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                // color: primaryColor,
                color: blueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: _isLoading ?
                      const Center(child: CircularProgressIndicator(color: primaryColor,),) :   
                      const Text('Sign Up'),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text("Already have an Account"),
              ),
              GestureDetector(
                onTap: () {
                  navigateToLogin();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text("Login.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Flexible(child: Container(),flex: 1,),

        ],
      ),
        )));
  }
}
