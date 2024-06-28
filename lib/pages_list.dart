import 'package:flutter/material.dart';
import 'package:youtube_clone/features/content/Long_video/long_video_screen.dart';

import 'features/content/short_video/pages/short_video_page.dart';
import 'features/search/pages/search_screen.dart';
import 'features/upload/short_video/pages/logout_page.dart';

List pages = const [
  LongVideoScreen(),
  ShortVideoPage(),
  Center(
    child: Text("upload"),
  ),
   SearchScreen(),
   LogoutPage(),
];
