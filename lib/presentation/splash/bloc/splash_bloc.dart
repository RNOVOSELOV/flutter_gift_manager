import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/presentation/theme/custom_theme.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TokenRepository tokenRepository;
  final SettingsRepository settingsRepository;
  final CustomTheme customTheme;

  SplashBloc({
    required this.tokenRepository,
    required this.customTheme,
    required this.settingsRepository,
  }) : super(SplashInitial()) {
    readAndSetThemeMode();
    on<SplashLoaded>(_onSplashLoaded);
  }

  Future<void> readAndSetThemeMode() async {
    ThemeMode? mode = ThemeMode.system;
    final settings = await settingsRepository.getItem();
    if (settings != null) {
      mode = settings.themeMode;
      mode ??= ThemeMode.system;
    }
    customTheme.setThemeMode(mode);
  }

  FutureOr<void> _onSplashLoaded(
    final SplashLoaded event,
    final Emitter<SplashState> emit,
  ) async {
    final token = await tokenRepository.getItem();
    if (token == null || token.isEmpty) {
      emit(const SplashUnauthorized());
    } else {
      setupAuthorizedBlocks ();
      emit(const SplashAuthorized());
    }
  }
}
