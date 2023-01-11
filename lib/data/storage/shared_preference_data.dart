import 'package:gift_manager/data/repository/refresh_token_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData extends RefreshTokenProvider {
  static const _tokenKey = "token_key";
  static const _refreshTokenKey = "refresh_token_key";
  static const _userKey = "user_key";
  static const _settingsKey = "settings_key";

  Future<bool> setToken(final String? token) =>
      _setItem(key: _tokenKey, item: token);

  Future<String?> getToken() => _getItem(_tokenKey);

  @override
  Future<bool> setRefreshToken(final String? refreshToken) =>
      _setItem(key: _refreshTokenKey, item: refreshToken);

  @override
  Future<String?> getRefreshToken() => _getItem(_refreshTokenKey);

  Future<bool> setUser(final String? user) =>
      _setItem(key: _userKey, item: user);

  Future<String?> getUser() => _getItem(_userKey);

  Future<String?> getSettings() => _getItem(_settingsKey);

  Future<bool> setSettings(final String? settings) =>
      _setItem(key: _settingsKey, item: settings);

  Future<bool> _setItem({
    required final String key,
    required final String? item,
  }) async {
    final sp = await SharedPreferences.getInstance();
    final result = sp.setString(key, item ?? '');
    return result;
  }

  Future<String?> _getItem(
    final String key,
  ) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}
