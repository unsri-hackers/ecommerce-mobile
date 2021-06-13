import 'package:another_flushbar/flushbar_helper.dart';
import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/controller/bloc/authentication/authentication_bloc.dart';
import 'package:deuvox/controller/bloc/login/login_bloc.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:deuvox/views/component/common_alert.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:deuvox/views/component/common_form.dart';
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
        body: Form(
          key: _formKey,
          child: BlocConsumer<LoginBloc, LoginState>(
            bloc: loginBloc,
            listener: (context, state) {
              if (state is LoginUserNotExisted) {
                Utils.showDialogError(context);
              }

              if (state is LoginFailure) {
                FlushbarHelper.createError(
                    message: "Gagal melakukan login. terjadi kesalahan")
                  ..show(context);
              }

              if (state is LoginSuccess) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CAlert(
                      imagePath: AssetsUtils.success,
                      message: 'Login\nSuccess',
                    );
                  },
                );
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedInEvent());
              }
            },
            builder: (context, state) {
              bool isDisabled = state is LoginSuccess;
              bool isLoading = state is LoginLoading;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    "Attack E-commerce",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 20),
                  CTextFormFilled(
                    hintText: "Username",
                    onSaved: (val) => loginModel.username = val,
                    validator: (value) =>
                        value!.isEmpty ? "Data belum lengkap" : null,
                  ),
                  SizedBox(height: 20),
                  CTextFormFilled(
                    hintText: "Password",
                    onSaved: (val) => loginModel.password = val,
                    validator: (value) =>
                        value!.isEmpty ? "Data belum lengkap" : null,
                  ),
                  SizedBox(height: 20),
                  CButtonFilled(
                    textLabel: "Login",
                    isLoading: isLoading,
                    onPressed: isDisabled
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();

                              loginBloc.add(LoginStarted(loginModel));
                            }
                          },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
