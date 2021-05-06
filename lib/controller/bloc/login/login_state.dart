part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String? error;

  const LoginFailure({this.error});

  @override
  List<Object> get props => [error!];
}

class LoginUserExisted extends LoginState {
}

class LoginUserNotExisted extends LoginState {}
class LoginUserSuspend extends LoginState {}

class LoginUserRegisterNotCompleted extends LoginState {}

class LoginFormError extends LoginState {
  final String? error;

  const LoginFormError({this.error});

  @override
  List<Object> get props => [error!];
}
