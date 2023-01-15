part of 'gift_bloc.dart';

abstract class GiftEvent extends Equatable {
  const GiftEvent();
}

class GiftPageLoaded extends GiftEvent {
  final GiftPageArgs args;

  const GiftPageLoaded({required this.args});

  @override
  List<Object?> get props => [];
}

class GiftInfoSendToServer extends GiftEvent {

  const GiftInfoSendToServer();

  @override
  List<Object?> get props => [];
}