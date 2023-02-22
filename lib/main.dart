// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack/providers/user_provider.dart';
import 'package:instagram_fullstack/responsive/mobile_screen_layout.dart';
import 'package:instagram_fullstack/responsive/responsive_layout_screen.dart';
import 'package:instagram_fullstack/responsive/web_screen_layout.dart';
import 'package:instagram_fullstack/screens/login_screen.dart';
import 'package:instagram_fullstack/screens/signup_screen.dart';
import 'package:instagram_fullstack/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDvDonhWNagAJoA89bi3MwrVX5C81IofiI",
          appId: "1:857685693240:web:c030829b8fe74488ade7cd",
          messagingSenderId: "857685693240",
          projectId: "instagram-clone-9195f",
          storageBucket: "instagram-clone-9195f.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // Persisting Authentication State
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider(),
          ),
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ${snapshot.error}'),
                );
              }
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          
            // If Snapshot has no data, then return Login Screen
            return const LoginScreen();
          
          },
        ),
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
    );
  }
}
