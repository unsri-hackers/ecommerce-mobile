part of 'app_cubit.dart';

class AppState extends Equatable {
   final LanguageModel language;
  final ThemeType themeType;
  AppState({required this.language, required this.themeType});

  List<Object> get props => [language, themeType];
}