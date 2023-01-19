// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonsDto _$PersonsDtoFromJson(Map<String, dynamic> json) => PersonsDto(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$PersonsDtoToJson(PersonsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };
