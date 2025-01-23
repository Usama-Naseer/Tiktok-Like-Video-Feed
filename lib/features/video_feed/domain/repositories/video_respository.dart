
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';

abstract class VideoRepository{
  Future<List<VideoEntity>> getVideoList(int page);

  Future<Null> addDemoData();
}
