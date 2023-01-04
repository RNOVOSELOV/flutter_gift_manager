import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto extends Equatable {
  final String email;
  final String password;

  factory LoginRequestDto.fromJson(final Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  const LoginRequestDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  @override
  List<Object?> get props => [email, password];
}
