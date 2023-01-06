part of 'gifts_bloc.dart';

abstract class GiftsState extends Equatable {
  const GiftsState();
}

class InitialGiftsLoadingState extends GiftsState {
  const InitialGiftsLoadingState();

  @override
  List<Object> get props => [];
}

class NoGiftsState extends GiftsState {
  const NoGiftsState();

  @override
  List<Object?> get props => [];
}

class InitialLoadingErrorState extends GiftsState {
  const InitialLoadingErrorState();

  @override
  List<Object?> get props => [];
}

class LoadedGiftsState extends GiftsState {
  const LoadedGiftsState({
    required this.gifts,
    required this.showLoading,
    required this.showError,
  }) : assert(!(showError && showLoading));

  final List<GiftDto> gifts;
  final bool showLoading;
  final bool showError;

  @override
  List<Object?> get props => [gifts, showLoading, showError];
}
