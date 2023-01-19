// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonsResponseDto _$PersonsResponseDtoFromJson(Map<String, dynamic> json) =>
    PersonsResponseDto(
      persons: (json['persons'] as List<dynamic>)
          .map((e) => PersonsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonsResponseDtoToJson(PersonsResponseDto instance) =>
    <String, dynamic>{
      'persons': instance.persons,
    };
