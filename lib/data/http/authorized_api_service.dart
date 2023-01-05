import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:gift_manager/data/http/base_api_service.dart';
import 'package:gift_manager/data/http/model/api_error.dart';
import 'package:gift_manager/data/http/model/gifts_response_dto.dart';

class AuthorizedApiService extends BaseApiService {
  final Dio _dio;

  AuthorizedApiService(this._dio);

  Future<Either<ApiError, GiftsResponseDto>> getAllGifts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    return responseOrError(() async {
      final response = await _dio.get(
        '/user/gifts',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      return GiftsResponseDto.fromJson(response.data);
    });
  }
}
