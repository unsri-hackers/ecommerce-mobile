import 'package:easy_localization/easy_localization.dart';
import 'package:deuvox/data/model/language_model.dart';

import '../config/themes.dart';

/// APP Configuration. Can be customized.
class AppConfig {
  static const String appName = "Deuvox";
  static const String appVersion = "0.1.0";

  /// Optional Variable for development environment
  /// `false` = production
  static const ENV_DEBUGGING = false; //false = production
  /// Default: `true`. disable this to hide any log
  static const ENABLE_LOGGING = true;

  /// base URL for Restful API
  static String get baseUrl {
    if (ENV_DEBUGGING) {
      return "https://deuvox-dev-1.herokuapp.com/api/v1";
    } else {
      return "https://deuvox-dev-1.herokuapp.com/api/v1";
    }
  }

  ///Endpoint api server to collect error/crash log in application
  static String get logsServerUrl => baseUrl + "/crashlog";

  static const int connectTimeout = 20000; //milisecond
  static const int receiveTimeout = 15000;

  /// Default Languages to be used
  static final LanguageModel defaultLanguage = supportedLanguageList[0];

  /// List of available langugages
  static final List<LanguageModel> supportedLanguageList = <LanguageModel>[
    LanguageModel(languageCode: 'en', countryCode: 'US', name: 'English'),
    LanguageModel(
        languageCode: 'id', countryCode: 'ID', name: 'Bahasa Indonesia'),
  ];

  /// Default Theme
  static final ThemeType defaultTheme = ThemeType.Light;

  /// Limit of data when using pagination
  static const int paginationLimit = 6;

  /// Default date format
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
}
