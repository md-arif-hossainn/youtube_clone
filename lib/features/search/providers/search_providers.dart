import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/upload/long_video/video_model.dart';

import '../../user_model.dart';

final allChannelsProvider = Provider((ref) async {
  final usersMap = await FirebaseFirestore.instance.collection("users").get();
  List<UserModel> users = usersMap.docs
      .map(
        (user) => UserModel.fromMap(
          user.data(),
        ),
      )
      .toList();
  return users;
});

final allVideosProvider = Provider((ref) async {
  final videosMap = await FirebaseFirestore.instance.collection("videos").get();
  List<VideoModel> videos = videosMap.docs
      .map(
        (video) => VideoModel.fromMap(
          video.data(),
        ),
      )
      .toList();
  return videos;
});

// Map<String, dynamic> videoMap = {
//   'id': '123',
//   'title': 'Sample Video',
//   'url': 'http://example.com'
// };
// VideoModel video = VideoModel.fromMap(videoMap);
//In this usage, VideoModel.fromMap(videoMap) calls the fromMap factory constructor to create and return an instance of VideoModel initialized with the values from videoMap.

// List<int> numbers = [1, 2, 3, 4, 5];
// List<int> doubledNumbers = numbers.map((number) => number * 2).toList();
//
// print(doubledNumbers); // Output: [2, 4, 6, 8, 10]








