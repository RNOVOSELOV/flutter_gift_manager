import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/http/model/user_with_tokens_dto.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';
import 'package:gift_manager/data/model/request_error.dart';
import 'package:gift_manager/data/repository/refresh_token_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/presentation/login/model/email_error.dart';
import 'package:gift_manager/presentation/login/model/password_error.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final _passwordRegexp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  LoginBloc() : super(LoginState.initial()) {
    on<LoginEmailChanged>(_loginEmailChanged);
    on<LoginPasswordChanged>(_loginPasswordChanged);
    on<LoginLoginButtonPressed>(_loginButtonClicked);
    on<LoginRequestErrorShowed>(_loginRequestErrorShowed);
  }

  FutureOr<void> _loginRequestErrorShowed(
      LoginRequestErrorShowed event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        requestError: RequestError.noError,
      ),
    );
  }

  FutureOr<void> _loginEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    final emailValid = _emailValid(email);
    emit(state.copyWith(
      email: email,
      emailIsValid: emailValid,
      emailError: EmailError.noError,
      authenticated: false,
    ));
  }

  bool _emailValid(final String email) {
    return EmailValidator.validate(email);
  }

  FutureOr<void> _loginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    final passwordValid = _passwordValid(password);
    emit(state.copyWith(
      password: password,
      passwordIsValid: passwordValid,
      passwordError: PasswordError.noError,
      authenticated: false,
    ));
  }

  bool _passwordValid(final String password) {
    //return _passwordRegexp.hasMatch(password);
    return password.length > 5;
  }

  FutureOr<void> _loginButtonClicked(
      LoginLoginButtonPressed event, Emitter<LoginState> emit) async {
    if (state.loginFieldsIsValid) {
      final response =
          await _login(email: state.email, password: state.password);

      debugPrint ("RESPONCE: $response");
      if (response != null) {
        await UserRepository.getInstance().setItem(response.user);
        await TokenRepository.getInstance().setItem(response.token);
        await RefreshTokenRepository.getInstance()
            .setItem(response.refreshToken);
        emit(state.copyWith(authenticated: true));
      } else {
        // TODO
        // switch (response) {
        //   case LoginError.emailNotExist:
        //     emit(state.copyWith(emailError: EmailError.notExist));
        //     break;
        //   case LoginError.wrongPassword:
        //     emit(state.copyWith(passwordError: PasswordError.wrongPassword));
        //     break;
        //   case LoginError.other:
        //     emit(state.copyWith(requestError: RequestError.unknown));
        //     break;
        // }
      }
    }
  }

  Future<UserWithTokensDto?> _login({
    required final String email,
    required final String password,
  }) async {
    final response = await UnauthorizedApiService.getInstance().login(
      email: email,
      password: password,
    );
    return response;
  }
}

enum LoginError {
  emailNotExist,
  wrongPassword,
  other,
}
