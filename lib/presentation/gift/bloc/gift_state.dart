part of 'gift_bloc.dart';

abstract class GiftState extends Equatable {
  const GiftState();
}

class GiftInitial extends GiftState {
  @override
  List<Object> get props => [];
}

class GiftSavingInProgress extends GiftState {
  const GiftSavingInProgress();

  @override
  List<Object?> get props => [];
}
