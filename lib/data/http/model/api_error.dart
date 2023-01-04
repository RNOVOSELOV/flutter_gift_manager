import 'package:gift_manager/data/http/api_error_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError extends Equatable {
  final dynamic code;
  final String? message;
  final String? error;

  factory ApiError.fromJson(final Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  const ApiError({
    required this.code,
    this.message,
    this.error,
  });

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  ApiErrorType get errorType => ApiErrorType.getByCode(code);

  @override
  List<Object?> get props => [code, message, error];
}
