import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_fullstack/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: Colors.white,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.messenger_outline,
            ),
          )
        ],
      ),
      body:  PostCard(),
    );
  }
}
