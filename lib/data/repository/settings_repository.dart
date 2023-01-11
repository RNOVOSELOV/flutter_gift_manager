import 'dart:convert';

import 'package:gift_manager/data/model/setting_parameters.dart';
import 'package:gift_manager/data/repository/base/reactive_repository.dart';
import 'package:gift_manager/data/storage/shared_preference_data.dart';

class SettingsRepository extends ReactiveRepository<SettingParameters> {
  SettingsRepository(this._spData);

  final SharedPreferenceData _spData;

  @override
  SettingParameters convertFromString(String rawItem) =>
      SettingParameters.fromJson(json.decode(rawItem));

  @override
  String convertToString(SettingParameters item) => json.encode(item.toJson());

  @override
  Future<String?> getRawData() => _spData.getSettings();

  @override
  Future<bool> saveRawData(String? item) => _spData.setSettings(item);
}
