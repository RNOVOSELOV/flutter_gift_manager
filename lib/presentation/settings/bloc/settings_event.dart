part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsPageLoaded extends SettingsEvent {
  const SettingsPageLoaded();

  @override
  List<Object?> get props => const [];
}

class SettingsLogout extends SettingsEvent {
  const SettingsLogout();

  @override
  List<Object?> get props => const [];
}

class SettingsThemeChanged extends SettingsEvent {
  final ThemeValues value;

  const SettingsThemeChanged({required this.value});

  @override
  List<Object?> get props => [value];
}
