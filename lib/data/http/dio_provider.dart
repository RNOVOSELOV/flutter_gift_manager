import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  Dio createDio() {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://giftmanager.skill-branch.ru/api'),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }
    return dio;
  }
}
