import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';

class API {
  late Dio dio;
  late String _apiKey;
  late String _baseUrl;

  API() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: log,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 3),
          Duration(seconds: 5),
        ],
        retryableExtraStatuses: {status403Forbidden},
      ),
    );
    _apiKey = "oq5MKZJoYecvEqBg70z0HTrLXxfDbvvAMzSrzkOO";
    _baseUrl =
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";
  }

  Future<List<dynamic>> fetchPhotos(String earthDate) async {
    try {
      Response response = await dio.request(
        _baseUrl,
        options: Options(method: "get"),
        queryParameters: {
          "earth_date": earthDate,
          "api_key": _apiKey,
        },
      );
      debugPrint("Status code is: ${response.statusCode}");
      return response.data["photos"];
    } catch (e) {
      if (e is DioException) {
        debugPrint("Dio Error: ${e.message}");
      } else {
        debugPrint("Normal Error: ${e.toString()}");
      }
      return [];
    }
  }
}
