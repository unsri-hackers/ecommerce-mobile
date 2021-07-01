import 'package:deuvox/controller/bloc/getuserprofile/get_user_profile_event.dart';
import 'package:deuvox/controller/bloc/getuserprofile/get_user_profile_state.dart';
import 'package:deuvox/data/domain/user_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserProfileBloc
    extends Bloc<GetUserProfileEvent, GetUserProfileState> {
  final UserDomain _userDomain;

  GetUserProfileBloc({UserDomain? userDomain})
      : _userDomain = userDomain ?? UserDomain(),
        super(GetUserProfileInitState());

  @override
  Stream<GetUserProfileState> mapEventToState(
      GetUserProfileEvent event) async* {
    if (event is GetUserProfileEvent) {
      yield* _mapGetProfileToState();
    }
  }

  Stream<GetUserProfileState> _mapGetProfileToState() async* {
    yield GetUserProfileLoadingState();
    try {
      var result = await _userDomain.getUserProfile();
      yield GetUserProfileSuccessState(user: result);
    } catch (e) {
      yield GetUserProfileFailedState(message: "");
    }
  }
}
