part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationEmailChanged extends RegistrationEvent {
  final String email;

  const RegistrationEmailChanged(this.email);

  @override
  List<Object?> get props => [];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;

  const RegistrationPasswordChanged(this.password);

  @override
  List<Object?> get props => [];
}

class RegistrationPasswordConfirmationChanged extends RegistrationEvent {
  final String passworConfirmation;

  const RegistrationPasswordConfirmationChanged(this.passworConfirmation);

  @override
  List<Object?> get props => [];
}

class RegistrationNameChanged extends RegistrationEvent {
  final String name;

  const RegistrationNameChanged(this.name);

  @override
  List<Object?> get props => [];
}

class RegistrationEmailFocusLost extends RegistrationEvent {
  const RegistrationEmailFocusLost();

  @override
  List<Object?> get props => [];
}

class RegistrationPasswordFocusLost extends RegistrationEvent {
  const RegistrationPasswordFocusLost();

  @override
  List<Object?> get props => [];
}

class RegistrationPasswordConfirmationFocusLost extends RegistrationEvent {
  const RegistrationPasswordConfirmationFocusLost();

  @override
  List<Object?> get props => [];
}

class RegistrationNameFocusLost extends RegistrationEvent {
  const RegistrationNameFocusLost();

  @override
  List<Object?> get props => [];
}

class RegistrationChangeAvatar extends RegistrationEvent {
  const RegistrationChangeAvatar();

  @override
  List<Object?> get props => [];
}

class RegistrationCreateAccount extends RegistrationEvent {
  const RegistrationCreateAccount();

  @override
  List<Object?> get props => [];
}
