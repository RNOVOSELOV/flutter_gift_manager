// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingParameters _$SettingParametersFromJson(Map<String, dynamic> json) =>
    SettingParameters(
      themeValue: $enumDecodeNullable(_$ThemeValuesEnumMap, json['themeValue']),
    );

Map<String, dynamic> _$SettingParametersToJson(SettingParameters instance) =>
    <String, dynamic>{
      'themeValue': _$ThemeValuesEnumMap[instance.themeValue],
    };

const _$ThemeValuesEnumMap = {
  ThemeValues.light: 'light',
  ThemeValues.dark: 'dark',
  ThemeValues.system: 'system',
};
