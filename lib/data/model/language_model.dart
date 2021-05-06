import 'dart:ui';

class LanguageModel {
  LanguageModel({required this.languageCode,
   required this.countryCode,this.name});
  late String languageCode;
  late String countryCode;
  late String? name;

  String  get localeTag{
    return this.languageCode+"-"+this.countryCode;
  }
  
  Locale toLocale() {
    return Locale(languageCode, countryCode);
  }

  static LanguageModel fromLocale(Locale locale) {
    return LanguageModel(
        languageCode: locale.languageCode, countryCode: locale.countryCode!, name: '');
  }

  LanguageModel.fromJson(Map<String, dynamic> json) {
    languageCode = json['languageCode'];
    countryCode = json['countryCode'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languageCode'] = this.languageCode;
    data['countryCode'] = this.countryCode;
    data['name'] = this.name;
    return data;
  }
}
