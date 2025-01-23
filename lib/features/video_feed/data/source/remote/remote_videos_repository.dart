import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_flutter/dummy/demo_data.dart';
import 'package:tiktok_flutter/features/video_feed/data/api_service/api_service.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

class RemoteVideosRepository implements VideoRepository {
  ApiService apiService = ApiService();
  Future<List<VideoEntity>> getVideoList(int page) async {
    try {
      final List<VideoEntity> videos = await apiService.loadVideos(page);
      return videos;
    } catch (e) {
      rethrow;
    }
  }

  Future<Null> addDemoData() async {
    for (var video in data) {
      await FirebaseFirestore.instance.collection("Videos").add(video);
    }
  }
}
