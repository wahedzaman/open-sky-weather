import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkManager {
  Future sendGetRequest(String url, {bool useToken = false}) async {
    debugPrint("calling : $url");
    final Dio dio = Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    if (useToken) {
      dio.options.headers["token"] = "";
    }

    final Response response = await dio.get(url).onError((error, stackTrace) {
      debugPrint("error calling get api : $url");
      debugPrint("error : $error");
      return Future.error(error.toString());
    });
    return response;
  }
}
