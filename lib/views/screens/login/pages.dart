import 'package:another_flushbar/flushbar_helper.dart';
import 'package:deuvox/controller/bloc/authentication/authentication_bloc.dart';
import 'package:deuvox/controller/bloc/login/login_bloc.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:deuvox/views/component/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    LoginModel loginModel = LoginModel();
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginUserNotExisted) {
                Utils.showDialogError(context);
              }

              if (state is LoginFailure) {
                FlushbarHelper.createError(
                    message: "Gagal melakukan login. terjadi kesalahan")
                  ..show(context);
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
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Username", border: OutlineInputBorder()),
                    onSaved: (val) => loginModel.username = val,
                    validator: (value) =>
                        value!.isEmpty ? "Data belum lengkap" : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Password", border: OutlineInputBorder()),
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

                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginStarted(loginModel));
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
