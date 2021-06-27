import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deuvox/data/domain/user_domain.dart';
import 'package:deuvox/data/model/user_model.dart';
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
          yield AuthenticationExpired(message: "Login Expired");
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
        UserSessionModel? userModel = await _userDomain.getCurrentSession();
        
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
      //TODO: only for wifreframe. Create real implementation later
      UserSessionModel userModel = await _userDomain.getCurrentSession();
      yield AuthenticationAuthenticated(user: userModel);
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    try {
      yield AuthenticationUnauthenticated();
      await _userDomain.logout();
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }
}
