import 'package:collection/collection.dart';
import 'package:gift_manager/presentation/settings/models/theme_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'setting_parameters.g.dart';

@JsonSerializable()
class SettingParameters extends Equatable {
  final ThemeValues? themeValue;

  factory SettingParameters.fromJson(final Map<String, dynamic> json) =>
      _$SettingParametersFromJson(json);

  const SettingParameters({required this.themeValue});

  Map<String, dynamic> toJson() => _$SettingParametersToJson(this);

  @override
  List<Object?> get props => [themeValue];
}

ThemeValues? themeValuesFromJson(String? value) {
  if (value == null) {
    return null;
  }
  final typeIdentificator = int.tryParse(value, radix: 10);
  return typeIdentificator == null
      ? null
      : ThemeValues.values
          .firstWhereOrNull((element) => element.valueId == typeIdentificator);
}

String? themeValuesToJson(ThemeValues? themeValue) {
  return themeValue?.valueId.toString();
}
