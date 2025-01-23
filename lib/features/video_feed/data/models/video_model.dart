import 'package:tiktok_flutter/features/video_feed/data/models/user_model.dart';
import 'package:tiktok_flutter/features/video_feed/data/models/video_url_model.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {

  VideoModel({
    required super.id,
    required super.duration,
    required super.user,
    required super.videoUrl,
    required super.url,required super.image,
    super.file
});

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    duration: json["duration"],
    url: json["url"],
    image: json["image"],
    user: UserModel.fromJson(json["user"]),
    videoUrl: VideoUrlModel.fromJson(json["video_files"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "duration": duration,
    "url": url,
    "image": image,
    "user": user.toJson(),
    "video_files": videoUrl.toJson(),
  };
}
