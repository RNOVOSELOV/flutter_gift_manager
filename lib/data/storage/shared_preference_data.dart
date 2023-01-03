import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  static const _tokenKey = "token_key";

  static SharedPreferenceData? _instance;

  factory SharedPreferenceData.getInstance() =>
      _instance ??= SharedPreferenceData._internal();

  SharedPreferenceData._internal();

  Future<bool> setToken(final String? token) =>
      _setItem(key: _tokenKey, item: token);

  Future<String?> getToken() => _getItem(_tokenKey);

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