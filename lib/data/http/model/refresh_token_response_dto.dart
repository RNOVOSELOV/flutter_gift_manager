import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'refresh_token_response_dto.g.dart';

@JsonSerializable()
class RefreshTokenResponseDto extends Equatable {
  final String token;
  final String refreshToken;

  factory RefreshTokenResponseDto.fromJson(final Map<String, dynamic> json) =>
      _$RefreshTokenResponseDtoFromJson(json);

  const RefreshTokenResponseDto(
      {required this.token, required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshTokenResponseDtoToJson(this);

  @override
  List<Object?> get props => [token, refreshToken];
}
