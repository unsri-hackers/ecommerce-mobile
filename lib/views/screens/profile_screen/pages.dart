import 'package:deuvox/app/config/app_config.dart';
import 'package:deuvox/controller/bloc/authentication/authentication_bloc.dart';
import 'package:deuvox/controller/bloc/getuserprofile/get_user_profile_bloc.dart';
import 'package:deuvox/controller/bloc/getuserprofile/get_user_profile_event.dart';
import 'package:deuvox/controller/bloc/getuserprofile/get_user_profile_state.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/screens/profile_screen/components.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserProfileBloc(),
      child: _ProfileScreenContainer(),
    );
  }
}

class _ProfileScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<GetUserProfileBloc>().add(GetUserProfileEvent());
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<GetUserProfileBloc, GetUserProfileState>(
                  builder: (context, state) {
                if (state is GetUserProfileSuccessState) {
                  return Column(
                    children: [
                      Container(
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(top: 16),
                          child: Utils.circularImage(state.user.avatar ?? ''),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          state.user.name ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is GetUserProfileLoadingState) {
                  return ProfileLoadingShimmer();
                }
                return Container();
              }),
              SizedBox(height: 16),
              TileMenu(
                icon: Icon(Icons.logout),
                title: LocaleKeys.logout.tr(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      content: Text(
                          LocaleKeys.logout_of.tr(args: [AppConfig.appName])),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              LocaleKeys.cancel.tr(),
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(AuthenticationLoggedOutEvent());
                            },
                            child: Text(LocaleKeys.logout.tr(),
                                style: TextStyle(color: Colors.black)))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
