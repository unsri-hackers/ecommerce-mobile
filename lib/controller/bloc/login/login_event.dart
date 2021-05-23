part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {
  final LoginModel form;

  const LoginStarted(this.form);

  @override
  List<Object> get props => [form];
}
