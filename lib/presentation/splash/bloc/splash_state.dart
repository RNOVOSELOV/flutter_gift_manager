part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashUnauthorized extends SplashState {
  const SplashUnauthorized();

  @override
  List<Object?> get props => [];
}

class SplashAuthorized extends SplashState {
  const SplashAuthorized();

  @override
  List<Object?> get props => [];
}
