import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_flutter/features/video_feed/presentation/feed_screen.dart';
import 'package:tiktok_flutter/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyB4GGL7zqYoZnHEa6yhBqxb8s_vtspaT8k',
      appId: '1:797907885817:android:75ca735bff2d397dc30c28',
      messagingSenderId: 'sendid',
      projectId: 'learn-fs5nik',
      storageBucket: 'learn-fs5nik.appspot.com',
    )
  );
  setup();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}
