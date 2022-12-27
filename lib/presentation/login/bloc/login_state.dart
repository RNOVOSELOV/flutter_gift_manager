part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final EmailError emailError;
  final String password;
  final PasswordError passwordError;
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool authenticated;
  final RequestError requestError;

  const LoginState(
      {required this.email,
      required this.emailError,
      required this.password,
      required this.passwordError,
      required this.emailIsValid,
      required this.passwordIsValid,
      required this.authenticated,
      required this.requestError});

  bool get loginFieldsIsValid => emailIsValid && passwordIsValid;

  factory LoginState.initial() => const LoginState(
        email: '',
        emailError: EmailError.noError,
        password: '',
        passwordError: PasswordError.noError,
        emailIsValid: false,
        passwordIsValid: false,
        authenticated: false,
        requestError: RequestError.noError,
      );

  LoginState copyWith({
    final String? email,
    final EmailError? emailError,
    final String? password,
    final PasswordError? passwordError,
    final bool? emailIsValid,
    final bool? passwordIsValid,
    final bool? authenticated,
    final RequestError? requestError,
  }) {
    return LoginState(
        email: email ?? this.email,
        emailError: emailError ?? this.emailError,
        password: password ?? this.password,
        passwordError: passwordError ?? this.passwordError,
        emailIsValid: emailIsValid ?? this.emailIsValid,
        passwordIsValid: passwordIsValid ?? this.passwordIsValid,
        authenticated: authenticated ?? this.authenticated,
        requestError: requestError ?? this.requestError);
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        emailIsValid,
        passwordIsValid,
        authenticated,
        requestError,
      ];
}
