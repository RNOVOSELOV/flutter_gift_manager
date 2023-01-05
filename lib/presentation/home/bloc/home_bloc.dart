import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/http/model/user_dto.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final LogoutInteractor logoutInteractor;
  late final StreamSubscription _logoutSubscription;

  HomeBloc({
    required this.userRepository,
    required this.logoutInteractor,
  }) : super(HomeInitial()) {
    on<HomePageLoaded>(_onHomePageLoaded);
    on<HomeLogoutPushed>(_onLogoutPushed);
    on<HomeExternalLogout>(_onHomeExternalLogout);
    _logoutSubscription = userRepository
        .observeItem()
        .where((user) => user == null)
        .take(1)
        .listen((_) => _logout());
  }

  FutureOr<void> _onHomePageLoaded(
    final HomePageLoaded event,
    final Emitter<HomeState> emit,
  ) async {
    final user = await userRepository.getItem();
    if (user == null) {
      _logout();
    } else {
      emit(HomeWithUser(user));
    }
  }

  FutureOr<void> _onLogoutPushed(
    final HomeLogoutPushed event,
    final Emitter<HomeState> emit,
  ) async {
    await logoutInteractor.logout();
    _logout();
  }

  void _logout() {
    add(const HomeExternalLogout());
  }

  @override
  Future<void> close() {
    _logoutSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onHomeExternalLogout(
      final HomeExternalLogout event, final Emitter<HomeState> emit) {
    emit(const HomeGoToLogin());
  }
}
