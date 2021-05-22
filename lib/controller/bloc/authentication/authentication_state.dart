part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserModel user;

  AuthenticationAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationAuthenticatedNotCompleted extends AuthenticationState {
  final UserModel user;

  AuthenticationAuthenticatedNotCompleted({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationFailureState { error: $message }';
}

class AuthenticationExpired extends AuthenticationState {
  final String message;

  AuthenticationExpired({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationExpiredState { error: $message }';
}
class AuthenticationLoading extends AuthenticationState {}
