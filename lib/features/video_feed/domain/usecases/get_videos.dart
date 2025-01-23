

import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

class GetAllVideosUserCase {
  GetAllVideosUserCase({
    required VideoRepository repository,
  }) : _repository = repository;

  final VideoRepository _repository;

  Future<List<VideoEntity>> call({int page = 1}) async {
    final list = await _repository.getVideoList(page);
    return list;
  }
}