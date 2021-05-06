import 'package:ecommerce_mobile/app/config/themes.dart';
import 'package:ecommerce_mobile/data/model/language_model.dart';

import '../../app/utils/hive_utils.dart';
import 'package:hive/hive.dart';
class AppDao {
  final HiveUtils dbProvider;
  AppDao() : dbProvider = HiveUtils(HiveBox.appconfig);
  String _languageKey = "lang";
  String _themeKey = "theme";

  Future<bool> setLanguange(LanguageModel language) async {
    final Box db = await dbProvider.dataBox;
    await db.put(_languageKey, language.toJson());
    return true;
  }

  Future<LanguageModel?> getLanguage() async {
    final db = await dbProvider.dataBox;
    if (db.isNotEmpty) {
      final maps = db.get(_languageKey);
      if (maps == null) return null;
      Map<String, dynamic> castData = Map<String, dynamic>.from(maps);
      return LanguageModel.fromJson(castData);
    } else {
      return null;
    }
  }

  Future<bool> setTheme(ThemeType themeType) async {
    final Box db = await dbProvider.dataBox;
    String themeVal = themeType == ThemeType.Dark ? "dark" : "light";
    await db.put(_themeKey, themeVal);
    return true;
  }

  Future<ThemeType> getTheme() async {
    final db = await dbProvider.dataBox;
    if (db.isNotEmpty) {
      final themeType = db.get(_themeKey);
      return themeType == "dark" ? ThemeType.Dark : ThemeType.Light;
    } else {
      return ThemeType.Light;
    }
  }

}
