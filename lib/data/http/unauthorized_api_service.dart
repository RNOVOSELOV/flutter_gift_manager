import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:gift_manager/data/http/api_error_type.dart';
import 'package:gift_manager/data/http/dio_provider.dart';
import 'package:gift_manager/data/http/model/api_error.dart';
import 'package:gift_manager/data/http/model/create_account_request_dto.dart';
import 'package:gift_manager/data/http/model/gifts_response_dto.dart';
import 'package:gift_manager/data/http/model/login_request_dto.dart';
import 'package:gift_manager/data/http/model/user_with_tokens_dto.dart';
import 'package:gift_manager/di/service_locator.dart';

class UnauthorizedApiService {
  final _dio = sl.get<DioProvider>().createDio();

  UnauthorizedApiService();

  Future<Either<ApiError, UserWithTokensDto>> register({
    required final String email,
    required final String password,
    required final String name,
    required final String avatarUrl,
  }) async {
    final requestBody = CreateAccountRequestDto(
      email: email,
      password: password,
      name: name,
      avatarUrl: avatarUrl,
    );
    try {
      final response =
          await _dio.post('/auth/create', data: requestBody.toJson());
      return Right(UserWithTokensDto.fromJson(response.data));
    } catch (e) {
      return Left(_getApiError(e));
    }
  }

  Future<Either<ApiError, UserWithTokensDto>> login({
    required final String email,
    required final String password,
  }) async {
    final requestBody = LoginRequestDto(
      email: email,
      password: password,
    );
    try {
      final response =
          await _dio.post('/auth/login', data: requestBody.toJson());
      return Right(UserWithTokensDto.fromJson(response.data));
    } catch (e) {
      return Left(_getApiError(e));
    }
  }

  Future<Either<ApiError, GiftsResponseDto>> getAllGifts({
    required final String token,
    final int limit = 10,
    final int offset = 0,
  }) async {
    try {
      final response = await _dio.get(
        '/user/gifts',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        }),
      );
      return Right(GiftsResponseDto.fromJson(response.data));
    } catch (e) {
      return Left(_getApiError(e));
    }
  }

  ApiError _getApiError(final dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.response && error.response != null) {
        try {
          final apiError = ApiError.fromJson(error.response!.data);
          return apiError;
        } catch (apiErr) {
          return const ApiError(code: ApiErrorType.unknown);
        }
      }
    }
    return const ApiError(code: ApiErrorType.unknown);
  }
}
