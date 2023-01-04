enum ApiErrorType {
  incorrectPassword(21),
  notFound(103),
  missingParams("E_MISSING_OR_INVALID_PARAMS"),
  unknown('unknown');

  const ApiErrorType(this.code);

  final dynamic code;

  static ApiErrorType getByCode(final dynamic code) {
    return ApiErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => ApiErrorType.unknown,
    );
  }
}
