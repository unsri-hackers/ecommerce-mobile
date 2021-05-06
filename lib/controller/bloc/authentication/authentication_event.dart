part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStartedEvent extends AuthenticationEvent {}

class AuthenticationLoggedInEvent extends AuthenticationEvent {}

class AuthenticationLoggedOutEvent extends AuthenticationEvent {}

class AuthenticationShowExpired extends AuthenticationEvent {}

class AuthenticationGetLoginProfile extends AuthenticationEvent {}