part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class SplashLoaded extends SplashEvent {
  const SplashLoaded();

  @override
  List<Object?> get props => [];
}
