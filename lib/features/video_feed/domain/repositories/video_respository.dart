
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';

abstract class VideoRepository{
  List<VideoEntity> listVideos = <VideoEntity>[];

  void load();

  Future<List<VideoEntity>> getVideoList();

  Future<Null> addDemoData();
}
