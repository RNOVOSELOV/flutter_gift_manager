import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'refresh_token_request_dto.g.dart';

@JsonSerializable()
class RefreshTokenRequestDto extends Equatable {
  final String refreshToken;

  factory RefreshTokenRequestDto.fromJson(final Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);

  const RefreshTokenRequestDto({required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshTokenRequestDtoToJson(this);

  @override
  List<Object?> get props => [refreshToken];
}
