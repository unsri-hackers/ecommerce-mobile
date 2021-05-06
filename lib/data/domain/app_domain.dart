


import '../../app/config/themes.dart';
import '../dao/app_dao.dart';
import '../model/language_model.dart';

class AppDomain {
  final AppDao _appDao = AppDao();

  Future<bool> setLanguange(LanguageModel language) {
    return _appDao.setLanguange(language);
  }

  Future<LanguageModel?> getLanguage() {
    return _appDao.getLanguage();
  }

  Future<bool> setTheme(ThemeType themeType) {
    return _appDao.setTheme(themeType);
  }

  Future<ThemeType?> getTheme() {
    return _appDao.getTheme();
  }
}
