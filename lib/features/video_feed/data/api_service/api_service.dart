import 'package:dio/dio.dart';
import 'package:tiktok_flutter/features/video_feed/data/models/video_model.dart';
import 'interceptors.dart';

class ApiService {

  Dio dio =  Dio();

  ApiService(){
    dio.interceptors.add(MyInterceptors());
  }

  Future<List<VideoModel>> loadVideos(int page) async {

    try{
      Response response= await  dio.get('https://api.pexels.com/videos/popular',queryParameters: {
        'page': 1,
        'per_page':10,
      },options: Options(headers: {
        'Authorization': 'HHCb9AN25uktaegwco9pUyArbyVYpwm8m5abIlkl6Gh1YXqyCzb9rWUL',
      }));
      if(response.statusCode == 200){
        return (response.data['videos'] as List).map((e)=> VideoModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load video');
      }
    }catch(e){
      throw Exception('Failed to load video');
    }
    
  }

}