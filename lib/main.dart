import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:youtube_clone/features/upload/long_video/video_details_page.dart';
import 'package:youtube_clone/home_page.dart';
import 'package:youtube_clone/login_page.dart';

import 'core/screens/loader.dart';
import 'features/channel/my_channel/pages/channel_settings.dart';
import 'features/channel/my_channel/pages/my_channel_screen.dart';
import 'features/pages/username_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // we check wthether we are signed in or not
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return  const Loader();
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              final user = FirebaseAuth.instance.currentUser;
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return UsernamePage(
                  displayName: user!.displayName!,
                  profilePic: user.photoURL!,
                  email: user.email!,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return const HomePage();
            },
          );
        },
      ),
    );
  }
}
