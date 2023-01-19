import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/model/persons_dto.dart';
import 'package:gift_manager/data/http/pagination_info.dart';

part 'peoples_event.dart';

part 'peoples_state.dart';

class PeoplesBloc extends Bloc<PeoplesEvent, PeoplesState> {
  static const _limit = 10;
  bool loading = false;
  bool errorHappened = false;
  final AuthorizedApiService authorizedApiService;

  final peoples = <PersonsDto>[];

  PaginationInfo paginationInfo = PaginationInfo.initial();

  PeoplesBloc({required this.authorizedApiService})
      : super(const PeoplesLoadingState()) {
    on<PeoplesPageLoaded>(_onPeoplesPageLoaded);
    on<PeoplesLoadingRequest>(_onPeoplesLoadingRequest);
    on<PeoplesAutoLoadingRequest>(_onPeoplesAutoLoadingRequest);
  }

  FutureOr<void> _onPeoplesPageLoaded(
      PeoplesPageLoaded event, Emitter<PeoplesState> emit) async {
    emit(const PeoplesLoadingState());
    await _loadPeoples(emit);
  }

  FutureOr<void> _onPeoplesLoadingRequest(
      PeoplesLoadingRequest event, Emitter<PeoplesState> emit) async {
    await _loadPeoples(emit);
  }

  FutureOr<void> _onPeoplesAutoLoadingRequest(
    PeoplesAutoLoadingRequest event,
    Emitter<PeoplesState> emit,
  ) async {
    if (errorHappened) {
      return;
    }
    await _loadPeoples(emit);
  }

  FutureOr<void> _loadPeoples(
    Emitter<PeoplesState> emit,
  ) async {
    if (loading) {
      return;
    }
    if (!paginationInfo.canLoadMore) {
      return;
    }
    loading = true;
    if (peoples.isEmpty) {
      emit(const PeoplesLoadingState());
    } else {
      emit(PeoplesLoadedState(
          peoples: [...peoples], showLoading: true, showError: false));
    }
    final peoplesResponse = await authorizedApiService.getAllPeoples(
      limit: _limit,
      offset: paginationInfo.lastLoadedPage * _limit,
    );
    if (peoplesResponse.isLeft) {
      errorHappened = true;
      if (peoples.isEmpty) {
        emit(const PeoplesLoadingErrorState());
      } else {
        emit(PeoplesLoadedState(
            peoples: [...peoples], showLoading: false, showError: true));
      }
    } else {
      errorHappened = false;
      final canLoadMore = peoplesResponse.right.persons.length == _limit;
      paginationInfo = PaginationInfo(
        canLoadMore: canLoadMore,
        lastLoadedPage: paginationInfo.lastLoadedPage + 1,
      );
      if (peoples.isEmpty && peoplesResponse.right.persons.isEmpty) {
        emit(const PeoplesLoadedEmptyState());
      } else {
        peoples.addAll(peoplesResponse.right.persons);
        emit(PeoplesLoadedState(
            peoples: [...peoples], showLoading: canLoadMore, showError: false));
      }
    }
    loading = false;
  }
}
