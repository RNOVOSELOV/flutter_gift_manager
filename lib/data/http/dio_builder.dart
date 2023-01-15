import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gift_manager/data/http/authorization_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioBuilder {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://giftmanager.skill-branch.ru/api',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    ),
  );

  DioBuilder() {
    if (kDebugMode) {
      _dio.interceptors.add(
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
  }

  Dio build() => _dio;

  DioBuilder addAuthorizationInterceptor(
      final AuthorizationInterceptor interceptor) {
    _dio.interceptors.add(interceptor);
    return this;
  }

  DioBuilder addHeaderPostmanParameters() {
//    _dio.options.contentType = 'application/json';
//    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['User-Agent'] = 'PostmanRuntime/7.30.0';
    return this;
  }
}
