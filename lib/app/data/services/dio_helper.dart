import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
        // baseUrl: 'http://192.168.1.17:8000/api/auth/user/',
  static init({path})  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://$path/api/auth/user/',
        receiveDataWhenStatusError: false,
      ),
    );
    // dio.transformer = FlutterTransformer();
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    // String lang = 'ar',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': '$lang',
      'Authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters: query);
  }

  // token is from FCM.getToken() method
  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'ar',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'ar',
    @required String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
