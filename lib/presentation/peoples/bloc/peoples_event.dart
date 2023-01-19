part of 'peoples_bloc.dart';

abstract class PeoplesEvent extends Equatable {
  const PeoplesEvent();
}

class PeoplesPageLoaded extends PeoplesEvent {
  const PeoplesPageLoaded();

  @override
  List<Object?> get props => [];
}

class PeoplesLoadingRequest extends PeoplesEvent {
  const PeoplesLoadingRequest();

  @override
  List<Object?> get props => const [];
}

class PeoplesAutoLoadingRequest extends PeoplesEvent {
  const PeoplesAutoLoadingRequest();

  @override
  List<Object?> get props => const [];
}
