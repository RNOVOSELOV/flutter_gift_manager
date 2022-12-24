import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginLoginButtonPressed>(_loginButtonClicked);
    on<LoginEmailChanged>(_loginEmailChanged);
  }

  FutureOr<void> _loginEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(LoginState.initial());
  }

  FutureOr<void> _loginButtonClicked(
      LoginLoginButtonPressed event, Emitter<LoginState> emit) {
    emit(state.copyWith(authenticated: true));
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
