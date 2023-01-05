import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/repository/token_repository.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TokenRepository tokenRepository;

  SplashBloc({required this.tokenRepository}) : super(SplashInitial()) {
    on<SplashLoaded>(_onSplashLoaded);
  }

  FutureOr<void> _onSplashLoaded(
    final SplashLoaded event,
    final Emitter<SplashState> emit,
  ) async {
    final token = await tokenRepository.getItem();
    if (token == null || token.isEmpty) {
      emit(const SplashUnauthorized());
    } else {
      emit(const SplashAuthorized());
    }
  }
}
