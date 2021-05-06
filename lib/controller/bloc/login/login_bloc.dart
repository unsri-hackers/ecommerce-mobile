import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../app/constant/error_code.dart';
import '../../../data/model/api_model.dart';
import '../../../data/domain/user_domain.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserDomain _userDomain;

  LoginBloc({UserDomain? userDomain})
      : _userDomain = userDomain ?? UserDomain(),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  Stream<LoginState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    try {
      yield LoginLoading();
      // final resData = await _userDomain.loginRequest(event.formLoginModel);
      yield LoginUserExisted();
    } catch (e) {
      if (e.runtimeType == CApiResError) {
        final CApiResError resError = e as CApiResError;
        switch (resError.errorCode) {
          case ErrorCode.USER_NOT_EXIST:
            yield LoginUserNotExisted();
            break;
          case ErrorCode.USER_SUSPEND:
            yield LoginUserSuspend();
            break;
          default:
            yield LoginFailure();
        }
      } else {
        yield LoginFailure();
      }
    }
  }
}
