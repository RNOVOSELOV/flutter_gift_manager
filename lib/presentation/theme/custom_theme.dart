import 'package:flutter/material.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  final SettingsRepository settingsRepository;

  ThemeMode get currentTheme => _themeMode;

  CustomTheme({required this.settingsRepository}) {
    readSettings();
  }

  Future<void> readSettings() async {
    final settings = await settingsRepository.getItem();
    if (settings == null) {
      return;
    }
    if (settings.themeMode == null) {
      return;
    }
    _themeMode = settings.themeMode!;
  }

  void setThemeMode(final ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
