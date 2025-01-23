// To parse this JSON data, do
//
//     final videoEntity = videoEntityFromJson(jsonString);


import 'package:tiktok_flutter/features/video_feed/data/models/user_model.dart';
import 'package:tiktok_flutter/features/video_feed/data/models/video_url_model.dart';

class VideoEntity {
  int id;
  int duration;
  String url;
  String image;
  UserModel user;
  VideoUrlModel videoUrl;
  String? file;

  VideoEntity({
    required this.id,
    required this.duration,
    required this.url,
    required this.image,
    required this.user,
    required this.videoUrl,
    this.file
  });

}



