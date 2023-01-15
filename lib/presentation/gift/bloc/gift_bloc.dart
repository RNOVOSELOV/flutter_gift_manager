import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/presentation/gift/view/gift_page.dart';

part 'gift_event.dart';

part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  late GiftPageArgs args;

  GiftBloc() : super(GiftInitial()) {
    on<GiftPageLoaded>(onGiftPageLoaded);
  }

  FutureOr<void> onGiftPageLoaded(
      GiftPageLoaded event, Emitter<GiftState> emit) {
    args = event.args;
  }
}
