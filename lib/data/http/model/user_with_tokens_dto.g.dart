// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_with_tokens_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithTokensDto _$UserWithTokensDtoFromJson(Map<String, dynamic> json) =>
    UserWithTokensDto(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$UserWithTokensDtoToJson(UserWithTokensDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
