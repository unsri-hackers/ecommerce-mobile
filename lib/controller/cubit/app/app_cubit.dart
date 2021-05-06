import 'package:bloc/bloc.dart';
import '../../../data/domain/app_domain.dart';
import '../../../app/config/app_config.dart';
import '../../../app/config/themes.dart';
import '../../../data/model/language_model.dart';
import 'package:equatable/equatable.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
            language: AppConfig.defaultLanguage,
            themeType: AppConfig.defaultTheme)) {
    getConfig();
  }

  AppDomain _appDomain = AppDomain();
  LanguageModel _language = AppConfig.defaultLanguage;
  ThemeType _themeType = AppConfig.defaultTheme;

  void getConfig() async {
    try {
      final language = await _appDomain.getLanguage() ?? AppConfig.defaultLanguage;
      final themeType = await _appDomain.getTheme() ?? _themeType;
      emit(AppState(
          language: language, themeType: themeType));
    } catch (e) {
      print(e);
    }
  }

  void setConfig(
      {LanguageModel? language, ThemeType? themeType}) async {
      if (language != null) {
        _language = language;
        await _appDomain.setLanguange(_language);
      }

      if (themeType != null) {
        _themeType = themeType;
        await _appDomain.setTheme(_themeType);
      }

      emit(AppState(
          language: _language,
          themeType: _themeType));
  }
}
