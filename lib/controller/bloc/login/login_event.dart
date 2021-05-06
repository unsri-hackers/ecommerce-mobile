part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  // final FormLoginModel formLoginModel;

  // const LoginButtonPressed({this.formLoginModel});

  // @override
  // List<Object> get props => [formLoginModel];
}
