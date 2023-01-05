// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftDto _$GiftDtoFromJson(Map<String, dynamic> json) => GiftDto(
      id: json['id'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GiftDtoToJson(GiftDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
      'price': instance.price,
    };
