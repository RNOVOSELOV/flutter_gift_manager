import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/model/setting_parameters.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';
import 'package:gift_manager/presentation/settings/models/theme_value.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  final UserRepository userRepository;
  final LogoutInteractor logoutInteractor;

  SettingsBloc({
    required this.logoutInteractor,
    required this.settingsRepository,
    required this.userRepository,
  }) : super(SettingsInitial()) {
    on<SettingsPageLoaded>(onSettingsPageLoaded);
    on<SettingsLogout>(onSettingsLogout);
    on<SettingsThemeChanged>(onSettingsThemeChanged);
  }

  FutureOr<void> onSettingsPageLoaded(
    SettingsPageLoaded event,
    Emitter<SettingsState> emit,
  ) async {
    final user = await userRepository.getItem();
    final settings = await settingsRepository.getItem();
    print('user: $user; settings: $settings');
    emit(SettingsParametersLoaded(
      userName: user?.name,
      userEmail: user?.email,
      userAvatarUrl: user?.avatarUrl,
      theme: settings?.themeValue ?? ThemeValues.light,
    ));
  }

  FutureOr<void> onSettingsLogout(
    SettingsLogout event,
    Emitter<SettingsState> emit,
  ) async {
    print('Logout clicked!!!');
    logoutInteractor.logout();
  }

  FutureOr<void> onSettingsThemeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await settingsRepository
        .setItem(SettingParameters(themeValue: event.value));
  }
}
