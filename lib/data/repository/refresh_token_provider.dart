abstract class RefreshTokenProvider {
  Future<bool> setRefreshToken(final String? refreshToken);

  Future<String?> getRefreshToken();
}