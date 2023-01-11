part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => const [];
}

class SettingsParametersLoaded extends SettingsState {
  final String? userName;
  final String? userEmail;
  final String? userAvatarUrl;
  final ThemeMode theme;

  const SettingsParametersLoaded({
    required this.userName,
    required this.userEmail,
    required this.userAvatarUrl,
    required this.theme,
  });

  @override
  List<Object?> get props => [
        userName,
        userEmail,
        userAvatarUrl,
        theme,
      ];
}
