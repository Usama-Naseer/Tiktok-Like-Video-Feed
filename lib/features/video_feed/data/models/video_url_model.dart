import 'package:tiktok_flutter/features/video_feed/domain/entities/video_url_entity.dart';

class VideoUrlModel extends VideoUrlEntity{

  VideoUrlModel({
    required super.id,
    required super.quality,
    required super.fileType,
    required super.width,
    required super.height,
    required super.fps,
    required super.link,
    required super.size,
  });

  factory VideoUrlModel.fromJson(Map<String, dynamic> json) => VideoUrlModel(
    id: json["id"],
    quality: json["quality"],
    fileType: json["file_type"],
    width: json["width"],
    height: json["height"],
    fps: json["fps"],
    link: json["link"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quality": quality,
    "file_type": fileType,
    "width": width,
    "height": height,
    "fps": fps,
    "link": link,
    "size": size,
  };
}
