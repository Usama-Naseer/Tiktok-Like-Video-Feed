import 'package:dio/dio.dart';
import 'package:tiktok_flutter/features/video_feed/data/models/video_model.dart';
import 'interceptors.dart';

class ApiService {

  Dio dio =  Dio();

  ApiService(){
    dio.options.baseUrl = 'https://api.example.com';
    dio.interceptors.add(MyInterceptors());
  }

  Future<List<VideoModel>> loadVideos(int page) async {
   Response response= await  dio.get('https://api.pexels.com/videos/popular?page=$page');
    if(response.statusCode == 200){
      return (response.data['video'] as List).map((e)=> VideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load video');
    }
    
  }

}