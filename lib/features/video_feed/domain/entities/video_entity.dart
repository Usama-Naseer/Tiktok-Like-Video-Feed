import 'package:video_player/video_player.dart';

class VideoEntity {
  String id;
  String user;
  String userPic;
  String videoTitle;
  String songName;
  String likes;
  String comments;
  String url;

  VideoPlayerController? controller;

  VideoEntity(
      {required this.id,
        required this.user,
        required this.userPic,
        required this.videoTitle,
        required this.songName,
        required this.likes,
        required this.comments,
        required this.url});
}
