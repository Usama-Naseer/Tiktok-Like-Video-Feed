
import 'package:dio/dio.dart';

class MyInterceptors extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Authorization': 'HHCb9AN25uktaegwco9pUyArbyVYpwm8m5abIlkl6Gh1YXqyCzb9rWUL',
      'Content-Type': 'application/json'
    });
  }
}