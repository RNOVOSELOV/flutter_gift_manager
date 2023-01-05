import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:gift_manager/data/http/base_api_service.dart';
import 'package:gift_manager/data/http/model/api_error.dart';
import 'package:gift_manager/data/http/model/create_account_request_dto.dart';
import 'package:gift_manager/data/http/model/login_request_dto.dart';
import 'package:gift_manager/data/http/model/refresh_token_request_dto.dart';
import 'package:gift_manager/data/http/model/refresh_token_response_dto.dart';
import 'package:gift_manager/data/http/model/user_with_tokens_dto.dart';

class UnauthorizedApiService extends BaseApiService {
  final Dio _dio;

  UnauthorizedApiService(this._dio);

  Future<Either<ApiError, UserWithTokensDto>> register({
    required final String email,
    required final String password,
    required final String name,
    required final String avatarUrl,
  }) async {
    return responseOrError(() async {
      final requestBody = CreateAccountRequestDto(
        email: email,
        password: password,
        name: name,
        avatarUrl: avatarUrl,
      );
      final response =
          await _dio.post('/auth/create', data: requestBody.toJson());
      return UserWithTokensDto.fromJson(response.data);
    });
  }

  Future<Either<ApiError, UserWithTokensDto>> login({
    required final String email,
    required final String password,
  }) async {
    return responseOrError(() async {
      final requestBody = LoginRequestDto(
        email: email,
        password: password,
      );
      final response =
          await _dio.post('/auth/login', data: requestBody.toJson());
      return UserWithTokensDto.fromJson(response.data);
    });
  }

  Future<Either<ApiError, RefreshTokenResponseDto>> refreshToken({
    required final String refreshToken,
  }) async {
    return responseOrError(() async {
      final requestBody = RefreshTokenRequestDto(
        refreshToken: refreshToken,
      );
      final response =
          await _dio.post('/auth/refresh', data: requestBody.toJson());
      return RefreshTokenResponseDto.fromJson(response.data);
    });
  }
}
