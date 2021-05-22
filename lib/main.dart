import 'package:catcher/catcher.dart';
import 'package:deuvox/views/screens/login/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/config/app_config.dart';
import 'app/config/router.dart';
import 'app/config/themes.dart';
import 'app/utils/assets_utils.dart';
import 'controller/bloc/authentication/authentication_bloc.dart';
import 'controller/cubit/app/app_cubit.dart';
import 'views/screens/upload_screen/pages.dart';
import 'views/screens/welcome_screen/pages.dart';

void main() async {
  // Catcher.reportCheckedError(error, stackTrace);
// Catcher.sendTestException();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (AppConfig.ENABLE_LOGGING) {
    Bloc.observer = MyBlocObserver();
  }

  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(
      handleWhenRejected: true,
    ),
    ToastHandler(customMessage: "An Application error has occured"),
    
  ]);

  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
    // ToastHandler(customMessage: "An Application error has occured"),
    HttpHandler(
      HttpRequestType.post,
      Uri.parse(AppConfig.logsServerUrl),
    )
  ]);

  Catcher(
    navigatorKey: GlobalKey<NavigatorState>(),
    rootWidget: EasyLocalization(
        supportedLocales:
            AppConfig.supportedLanguageList.map((e) => e.toLocale()).toList(),
        path: AssetsUtils.langPath,
        startLocale: AppConfig.defaultLanguage.toLocale(),
        fallbackLocale: AppConfig.defaultLanguage.toLocale(),
        child: MyApp()),
    debugConfig: debugOptions,
    ensureInitialized: true,
    releaseConfig: releaseOptions,
  );

  // Catcher.reportCheckedError(error, stackTrace);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              AuthenticationBloc()..add(AuthenticationStartedEvent()),
        ),
          BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) async =>await
            context.setLocale(state.language.toLocale()),
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, AppState appState) {
    return MaterialApp(
        navigatorKey: Catcher.navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale, //
        title: AppConfig.appName,
        theme: ThemeStyle.getAppThemeData(context, appState.themeType),
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        home: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
              if (state is AuthenticationExpired) {
                _showExpiredAlert(context);
              }
            }),
          ],
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            buildWhen: (previous, current) => current is!AuthenticationExpired,
              builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUnauthenticated) {
              return UploadScreen();
              // return LoginScreen();
            }
            if (state is AuthenticationAuthenticated) {
              return WelcomeScreen();
            }
            return Center(child: CircularProgressIndicator());
          }),
        ));
  }

  void _showExpiredAlert(BuildContext subContext) {
    //showModalBottom Info
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc? bloc, Object? event) {
    super.onEvent(bloc!, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }
}
