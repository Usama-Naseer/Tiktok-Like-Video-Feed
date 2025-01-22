import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:video_player/video_player.dart';

class VideoModel extends VideoEntity {

  VideoModel(
      {required super.id,
      required super.user,
      required super.userPic,
      required super.videoTitle,
      required super.songName,
      required super.likes,
      required super.comments,
      required super.url}){
   loadController();
  }

  factory VideoModel.fromJson(Map<dynamic, dynamic> json){
    return VideoModel(
        id : json['id'],
        user : json['user'],
        userPic : json['user_pic'],
        videoTitle : json['video_title'],
        songName : json['song_name'],
        likes : json['likes'],
        comments : json['comments'],
        url : json['url']
    );

  }
      
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user;
    data['user_pic'] = userPic;
    data['video_title'] = videoTitle;
    data['song_name'] = songName;
    data['likes'] = likes;
    data['comments'] = comments;
    data['url'] = url;
    return data;
  }

  Future<Null> loadController() async {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
