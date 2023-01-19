import 'package:gift_manager/data/http/model/persons_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'persons_response_dto.g.dart';

@JsonSerializable()
class PersonsResponseDto extends Equatable {
  final List<PersonsDto> persons;

  factory PersonsResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$PersonsResponseDtoFromJson(json);

  const PersonsResponseDto({required this.persons});

  Map<String, dynamic> toJson() => _$PersonsResponseDtoToJson(this);

  @override
  List<Object?> get props => [persons];
}
