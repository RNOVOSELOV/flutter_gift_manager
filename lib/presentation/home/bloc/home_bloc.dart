import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';
import 'package:gift_manager/data/http/model/user_dto.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final LogoutInteractor logoutInteractor;
  final UnauthorizedApiService unauthorizedApiService;
  final TokenRepository tokenRepository;

  late final StreamSubscription _logoutSubscription;

  HomeBloc({
    required this.userRepository,
    required this.unauthorizedApiService,
    required this.tokenRepository,
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
    final token = await tokenRepository.getItem();
    if (user == null || token == null) {
      _logout();
    } else {
      final giftsResponse =
          await unauthorizedApiService.getAllGifts(token: token);
      final gifts =
          giftsResponse.isRight ? giftsResponse.right.gifts : const <GiftDto>[];
      emit(HomeWithUserInfo(user: user, gifts: gifts));
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
