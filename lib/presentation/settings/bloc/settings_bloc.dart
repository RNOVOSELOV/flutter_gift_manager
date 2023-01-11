import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/model/setting_parameters.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';
import 'package:gift_manager/presentation/theme/custom_theme.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  final UserRepository userRepository;
  final LogoutInteractor logoutInteractor;
  final CustomTheme customTheme;

  SettingsBloc({
    required this.logoutInteractor,
    required this.settingsRepository,
    required this.userRepository,
    required this.customTheme,
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
      theme: settings?.themeMode ?? ThemeMode.system,
    ));
  }

  FutureOr<void> onSettingsLogout(
    SettingsLogout event,
    Emitter<SettingsState> emit,
  ) async {
    await logoutInteractor.logout();
  }

  FutureOr<void> onSettingsThemeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await settingsRepository
        .setItem(SettingParameters(themeMode: event.value));
    customTheme.setThemeMode(event.value);
  }
}
