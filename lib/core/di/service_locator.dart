import 'package:get_it/get_it.dart';
import 'package:tiktok_flutter/features/video_feed/data/source/remote/remote_videos_repository.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<VideoRepository>(RemoteVideosRepository());
}

