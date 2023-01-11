// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingParameters _$SettingParametersFromJson(Map<String, dynamic> json) =>
    SettingParameters(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$SettingParametersToJson(SettingParameters instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
