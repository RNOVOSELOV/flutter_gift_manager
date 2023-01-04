import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  factory UserDto.fromJson(final Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  List<Object?> get props => [id, name, email, avatarUrl];
}
