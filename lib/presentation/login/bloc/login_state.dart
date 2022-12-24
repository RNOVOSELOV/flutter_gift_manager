part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool emailIsValid;
  final bool passwordIsValid;
  final bool authenticated;

  const LoginState({
    required this.email,
    required this.password,
    required this.emailIsValid,
    required this.passwordIsValid,
    required this.authenticated,
  });

  @override
  List<Object?> get props =>
      [email, password, emailIsValid, passwordIsValid, authenticated];

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        emailIsValid: false,
        passwordIsValid: false,
        authenticated: false,
      );

  LoginState copyWith({
    final String? email,
    final String? password,
    final bool? emailIsValid,
    final bool? passwordIsValid,
    final bool? authenticated,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailIsValid: emailIsValid ?? this.emailIsValid,
      passwordIsValid: passwordIsValid ?? this.passwordIsValid,
      authenticated: authenticated ?? this.authenticated,
    );
  }
}
