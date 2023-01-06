import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';

part 'gifts_event.dart';

part 'gifts_state.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  GiftsBloc({required this.authorizedApiService})
      : super(const InitialGiftsLoadingState()) {
    on<GiftsPageLoaded>(_onGiftsPageLoaded);
    on<GiftsLoadingRequest>(_onGiftsLoadingRequest);
  }

  final AuthorizedApiService authorizedApiService;
  final gifts = <GiftDto>[];

  bool initialErrorHappened = false;
  bool loading = false;

  FutureOr<void> _onGiftsPageLoaded(
    GiftsPageLoaded event,
    Emitter<GiftsState> emit,
  ) async {
    await _loadGifts(emit);
  }

  FutureOr<void> _onGiftsLoadingRequest(
    GiftsLoadingRequest event,
    Emitter<GiftsState> emit,
  ) async {
    await _loadGifts(emit);
  }

  FutureOr<void> _loadGifts(
    Emitter<GiftsState> emit,
  ) async {
    if (loading) {
      return;
    }
    loading = true;
    if (gifts.isEmpty) {
      emit(const InitialGiftsLoadingState());
    }
    final giftsResponse = await authorizedApiService.getAllGifts();
    if (giftsResponse.isLeft) {
      initialErrorHappened = true;
      if (gifts.isEmpty) {
        emit(const InitialLoadingErrorState());
      } else {
        emit(LoadedGiftsState(
            gifts: gifts, showLoading: false, showError: true));
      }
    } else {
      initialErrorHappened = false;
      if (giftsResponse.right.gifts.isEmpty) {
        emit(const NoGiftsState());
      } else {
        emit(const InitialLoadingErrorState());
        gifts.addAll(giftsResponse.right.gifts);
        emit(LoadedGiftsState(
            gifts: gifts, showLoading: true, showError: false));
      }
    }
    loading = false;
  }
}
