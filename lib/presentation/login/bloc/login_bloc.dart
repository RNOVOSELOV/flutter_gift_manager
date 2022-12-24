import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEmailChanged>(_loginEmailChanged);
    on<LoginPasswordChanged>(_loginPasswordChanged);
    on<LoginLoginButtonPressed>(_loginButtonClicked);
  }

  FutureOr<void> _loginEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    final emailValid = email.length > 4;
    emit(state.copyWith(email: email, emailIsValid: emailValid));
  }

  FutureOr<void> _loginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    final passwordValid = password.length >= 8;
    emit(state.copyWith(password: password, passwordIsValid: passwordValid));
  }

  FutureOr<void> _loginButtonClicked(
      LoginLoginButtonPressed event, Emitter<LoginState> emit) {
    if (state.passwordIsValid && state.emailIsValid) {
      emit(state.copyWith(authenticated: true));
    }
  }

  @override
  void onEvent(LoginEvent event) {
    debugPrint("Login bloc. Event happened: $event");
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    debugPrint("Login bloc. Transition happened: $transition");
    super.onTransition(transition);
  }
}
