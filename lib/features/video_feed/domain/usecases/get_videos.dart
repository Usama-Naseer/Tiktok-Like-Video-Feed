

import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

class GetAllVideos {
  GetAllVideos({
    required VideoRepository repository,
  }) : _repository = repository;

  final VideoRepository _repository;

  Future<List<VideoEntity>> call({int page = 0}) async {
    final list = await _repository.getVideoList();
    return list;
  }
}