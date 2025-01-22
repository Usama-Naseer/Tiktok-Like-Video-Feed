import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_flutter/dummy/demo_data.dart';
import 'package:tiktok_flutter/features/video_feed/data/models/video_model.dart';
import 'package:tiktok_flutter/features/video_feed/domain/entities/video_entity.dart';
import 'package:tiktok_flutter/features/video_feed/domain/repositories/video_respository.dart';

class RemoteVideosRepository implements VideoRepository {
  Future<List<VideoEntity>> getVideoList() async {
    try {
      var data = await FirebaseFirestore.instance.collection("Videos").get();
      var videoList = <VideoModel>[];
      var videos;

      if (data.docs.length == 0) {
        await addDemoData();
        videos = (await FirebaseFirestore.instance.collection("Videos").get());
      } else {
        videos = data;
      }
      videos.docs.forEach((element) async {
        VideoModel video = VideoModel.fromJson(element.data());
        // await video.loadController();
        videoList.add(video);
      });

      return videoList;
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
