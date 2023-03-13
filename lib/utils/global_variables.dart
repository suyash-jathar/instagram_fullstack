import 'package:flutter/material.dart';
import 'package:instagram_fullstack/screens/add_post_screen.dart';
import 'package:instagram_fullstack/screens/feed_screen.dart';

const webScreenSize=600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Favorite'),
  Text('Profile'),
];