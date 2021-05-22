import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:deuvox/data/domain/user_domain.dart';
import 'package:deuvox/data/model/user_model.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({AuthenticationState? state})
      : super(state ?? AuthenticationInitial());
  final UserDomain _userDomain = UserDomain();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStartedEvent) {
      yield* _mapAppStartedToState();
    }

    if (event is AuthenticationLoggedInEvent) {
      yield* _mapLoggedInToState();
    }

    if (event is AuthenticationLoggedOutEvent) {
      yield* _mapLoggedOutToState();
    }
    if (event is AuthenticationShowExpired) {
      try {
        final isSignedIn = await _userDomain.isLoggedIn();
        if (isSignedIn) {
          yield AuthenticationExpired(
              message:
                  LocaleKeys.login_session_expired.tr());
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userDomain.isLoggedIn();
      if (isSignedIn) {
        UserModel? userModel = await _userDomain.getCurrentSession();
        yield AuthenticationAuthenticated(user: userModel);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      UserModel userModel = await _userDomain.getCurrentSession();
      yield AuthenticationAuthenticated(user: userModel);
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    try {
      yield AuthenticationUnauthenticated();
      await _userDomain.logout();
      yield AuthenticationUnauthenticated();
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  
}
