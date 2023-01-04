// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequestDto _$CreateAccountRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateAccountRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$CreateAccountRequestDtoToJson(
        CreateAccountRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
