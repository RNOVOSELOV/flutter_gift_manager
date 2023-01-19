import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'persons_dto.g.dart';

@JsonSerializable()
class PersonsDto extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;

  factory PersonsDto.fromJson(final Map<String, dynamic> json) =>
      _$PersonsDtoFromJson(json);

  const PersonsDto({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => _$PersonsDtoToJson(this);

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
