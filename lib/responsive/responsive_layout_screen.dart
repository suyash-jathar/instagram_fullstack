import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/dimensions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData()async{
    UserProvider _userProvider=Provider.of(context,listen:false);
    await _userProvider.refreshUser();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:instagram_fullstack/providers/user_provider.dart';
// import 'package:instagram_fullstack/utils/dimensions.dart';
// import 'package:provider/provider.dart';


// class ResponsiveLayout extends StatefulWidget {
//   final Widget webScreenLayout;
//   final Widget mobileScreenLayout;
//   const ResponsiveLayout({Key? key,required this.webScreenLayout,required this.mobileScreenLayout}):super(key: key);

//   @override
//   State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
// }

// class _ResponsiveLayoutState extends State<ResponsiveLayout> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     addData();
//   }

// // To call refereshUser so that the '_user' global variable gets updated and store value 
// // in it otherwise it will return null value
//   addData()async{
//     UserProvider _userProvider=Provider.of(context,listen: false);
//     await _userProvider.refreshUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth > webScreenSize) {
//           return  widget.webScreenLayout;
//         }  
//         else {
//           return widget.mobileScreenLayout;
//         }
//       },
//     );
//   }
// }