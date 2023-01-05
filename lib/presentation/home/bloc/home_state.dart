part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeWithUserInfo extends HomeState {
  final UserDto user;
  final List<GiftDto> gifts;

  const HomeWithUserInfo({required this.user, required this.gifts});

  @override
  List<Object?> get props => [user, gifts];
}

class HomeGoToLogin extends HomeState {
  const HomeGoToLogin();

  @override
  List<Object?> get props => const [];
}
