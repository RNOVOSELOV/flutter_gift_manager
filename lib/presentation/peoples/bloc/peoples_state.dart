part of 'peoples_bloc.dart';

abstract class PeoplesState extends Equatable {
  const PeoplesState();
}

class PeoplesLoadingState extends PeoplesState {
  const PeoplesLoadingState();

  @override
  List<Object> get props => [];
}

class PeoplesLoadedEmptyState extends PeoplesState {
  const PeoplesLoadedEmptyState();

  @override
  List<Object?> get props => [];
}

class PeoplesLoadingErrorState extends PeoplesState {
  const PeoplesLoadingErrorState();

  @override
  List<Object?> get props => [];
}

class PeoplesLoadedState extends PeoplesState {
  const PeoplesLoadedState({
    required this.peoples,
    required this.showLoading,
    required this.showError,
  });// : assert(!(showError && showLoading));

  final List<PersonsDto> peoples;
  final bool showLoading;
  final bool showError;

  @override
  List<Object?> get props => [peoples, showLoading, showError];
}
