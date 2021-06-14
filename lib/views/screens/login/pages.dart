import 'package:another_flushbar/flushbar_helper.dart';
import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/app/utils/font_utils.dart';
import 'package:deuvox/app/utils/router_utils.dart';
import 'package:deuvox/controller/bloc/authentication/authentication_bloc.dart';
import 'package:deuvox/controller/bloc/login/login_bloc.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/component/common_alert.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
import 'package:deuvox/views/component/common_widget.dart';
import 'package:deuvox/views/component/curve_clipper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel loginModel = LoginModel();
  LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    loginBloc = LoginBloc();

    super.initState();
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: Scaffold(
        body: ListView(
          children: [
            CurveHeader(
              imgAssetPlaceholder: AssetsUtils.login
            ),
            Text(
              LocaleKeys.welcome_back.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                
                fontSize: 36,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                LocaleKeys.sign_in_to_your_account.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  listener: (context, state) {
                    if (state is LoginUserNotExisted) {
                      Utils.showDialogError(context);
                    }

                    if (state is LoginFailure) {
                      FlushbarHelper.createError(
                          message: LocaleKeys.failed_to_login.tr())
                        ..show(context);
                    }

                    if (state is LoginSuccess) {
                      bool popupOpened = true;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CAlert(
                            imagePath: AssetsUtils.success,
                            message: LocaleKeys.login_success.tr(),
                          );
                        },
                      ).then((value) {
                        popupOpened = false;
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationLoggedInEvent());
                      });
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        if (popupOpened) Navigator.pop(context);
                      });
                    }
                  },
                  builder: (context, state) {
                    bool isDisabled = state is LoginSuccess;
                    bool isLoading = state is LoginLoading;
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 12),
                        CTextFormFilled(
                          labelText: LocaleKeys.email_address.tr(),
                          onSaved: (val) => loginModel.username = val,
                          validator: (value) => value!.isEmpty
                              ? LocaleKeys.data_not_complete.tr()
                              : null,
                        ),
                        SizedBox(height: 8),
                        CTextFormFilled(
                          labelText: LocaleKeys.password.tr(),
                          onSaved: (val) => loginModel.password = val,
                          validator: (value) => value!.isEmpty
                              ? LocaleKeys.data_not_complete.tr()
                              : null,
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          child: CButtonFilled(
                            textLabel: LocaleKeys.login.tr(),
                            isLoading: isLoading,
                            rounded: true,
                            onPressed: isDisabled
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState?.save();

                                      loginBloc.add(LoginStarted(loginModel));
                                    }
                                  },
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(thickness: 2),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 32),
                          child: CButtonFilled(
                            textLabel: LocaleKeys.login_with_google.tr(),
                            isLoading: isLoading,
                            rounded: true,
                            outlined: true,
                            image: Image.asset(AssetsUtils.googleLogo),
                            primaryColor: Colors.white,
                            onPressed: isDisabled
                                ? null
                                : () {
                                    FlushbarHelper.createInformation(
                                        message: LocaleKeys.coming_soon.tr())
                                      ..show(context);
                                  },
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              FlushbarHelper.createInformation(
                                  message: LocaleKeys.coming_soon.tr())
                                ..show(context);
                            },
                            child: Text(
                              LocaleKeys.forgot_password.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              FlushbarHelper.createInformation(
                                  message: LocaleKeys.coming_soon.tr())
                                ..show(context);
                            },
                            child: Text(
                              LocaleKeys.havent_register_yet_register_now.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
