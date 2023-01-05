// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifts_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftsResponseDto _$GiftsResponseDtoFromJson(Map<String, dynamic> json) =>
    GiftsResponseDto(
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => GiftDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GiftsResponseDtoToJson(GiftsResponseDto instance) =>
    <String, dynamic>{
      'gifts': instance.gifts,
    };
