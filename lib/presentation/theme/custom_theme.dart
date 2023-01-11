import 'package:flutter/material.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';
import 'package:gift_manager/presentation/settings/models/theme_value.dart';

class CustomTheme with ChangeNotifier {
  late bool _isDarkTheme;

  final SettingsRepository settingsRepository;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  CustomTheme({required this.settingsRepository}) {
    _isDarkTheme = true;
    readSettings();
  }

  Future<void> readSettings() async {
    final settings = await settingsRepository.getItem();
    if (settings == null) {
      _isDarkTheme = false;
      return;
    }
    if (settings.themeValue == ThemeValues.light) {
      _isDarkTheme = false;
    }
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
