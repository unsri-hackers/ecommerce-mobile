import 'package:flutter/material.dart';

enum ThemeType { Light, Dark }
/// List of available colors for this theme
class ThemeColors {
  ///Primary actions, buttons, links & success states
  static const Color green50 = Color(0xFF31B057);

  ///Pressed states & creating gradients
  static const Color green40 = Color(0xFF51C273);

  static const Color green80 = Color(0xFF0F752E);

  ///Product specific color for MY-FOOD
  static const Color red50 = Color(0xFFE52A34);

  ///All error text, negative states
  static const Color red60 = Color(0xFFCF212A);

  ///Product specific color for T-PAY
  static const Color blue50 = const Color(0xFF388BF2);

  static const MaterialColor blue = MaterialColor(
    0xFF388BF2,
    <int, Color>{
      100: Color(0xFFDBEBFF),
      400: Color(0xFF5BA0f5),
      500: blue50,
      600: Color(0xFF216BC4),
      700: Color(0xFF1A5BAC),
      800: Color(0xFF114D96),
    },
  );

  ///Product specific color for MY-POINTS
  static const Color yellow50 = Color(0xFFFBAF18);

  ///Product specific color for GO-TIX
  static const Color orange50 = Color(0xFFFC8338);

  ///Title texts, icons, captions, input fields & everywhere else where black is required
  static const Color black100 = Color(0xFF25282B);

  ///Body text & component description
  static const Color black80 = Color(0xFF52575C);

  static const Color black50 = Color(0xFF25282B);

  ///Inactive states of icons & other components
  static const Color black60 = Color(0xFFA0A4A8);

  ///Default texts in text field, disabled states of buttons, icons & other components
  static const Color black40 = Color(0xFFCACCCF);

  ///Dividers & borders
  static const Color black10 = Color(0xFFE8E8E8);
}

/// Defined Style for Light and Dark Theme
class ThemeStyle {
  static const String headerFont = "NeoSansPro";
  static const String bodyFont = "Roboto";

  static const TextStyle hyperlink = TextStyle(color: ThemeColors.green50);

  static const TextStyle brandName = TextStyle(
      fontFamily: headerFont, fontSize: 32, fontWeight: FontWeight.w700);

  static const TextStyle brandNameAppBar = TextStyle(
      fontFamily: headerFont, fontSize: 20, fontWeight: FontWeight.w700);

  static const TextStyle headerMedium21 = TextStyle(
      fontFamily: headerFont, fontSize: 21, fontWeight: FontWeight.w500);

  static const TextStyle headerMedium18 = TextStyle(
      fontFamily: headerFont, fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle headerMedium15 = TextStyle(
      fontFamily: headerFont, fontSize: 15, fontWeight: FontWeight.w500);

  static const TextStyle headerMedium12 = TextStyle(
      fontFamily: headerFont, fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle headerMedium14 = TextStyle(
      fontFamily: headerFont, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle bodyRegular14 = TextStyle(
    fontSize: 14,
  );

  static const TextStyle bodyRegular15 = TextStyle(
    fontSize: 15,
  );
  static const TextStyle bodyRegular16 = TextStyle(
    fontSize: 16,
  );

  static const TextStyle bodyRegular18 = TextStyle(
    fontSize: 18,
  );

  static const TextStyle bodyRegular12 = TextStyle(
    fontSize: 12,
  );

  static const TextStyle bodyRegular10_5 = TextStyle(
    fontSize: 10.5,
  );

  static final appThemeData = {
    ThemeType.Light: ThemeData.light().copyWith(
         pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),

          },
        ),
        primaryColor: ThemeColors.green50,
        primaryColorDark: ThemeColors.green80,
        primaryColorLight: ThemeColors.green40,
        accentColor: ThemeColors.black80,
        disabledColor: ThemeColors.black40,
        // colorScheme: ColorScheme.light(),
        buttonTheme: ButtonThemeData(
            buttonColor: ThemeColors.green50,
            textTheme: ButtonTextTheme.primary,
            disabledColor: ThemeColors.black40),
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 2,
            iconTheme: IconThemeData(color: ThemeColors.black100),
            textTheme: TextTheme(
                headline6: ThemeStyle.headerMedium18
                    .copyWith(color: ThemeColors.black100))),
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        dividerColor: ThemeColors.black10,
        dividerTheme: DividerThemeData(
          color: ThemeColors.black10,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedLabelStyle: ThemeStyle.headerMedium12,
            selectedLabelStyle: ThemeStyle.headerMedium12),
        shadowColor: ThemeColors.black100.withOpacity(0.3),
        snackBarTheme: SnackBarThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: ThemeColors.black60,
            contentTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ThemeColors.green50,
        ),
        textTheme: TextTheme(
          headline6: ThemeStyle.headerMedium18
              .copyWith(color: ThemeColors.black100, fontSize: 14),
          headline5:
              ThemeStyle.headerMedium15.copyWith(color: ThemeColors.black100),
          headline4:
              ThemeStyle.headerMedium18.copyWith(color: ThemeColors.black100),
          headline3: ThemeStyle.headerMedium21.copyWith(
            height: 1.5,
            color: ThemeColors.black100,
          ),
          headline2: ThemeStyle.headerMedium21
              .copyWith(color: ThemeColors.black100, fontSize: 25),
          headline1: ThemeStyle.headerMedium21
              .copyWith(color: ThemeColors.black100, fontSize: 28),
          bodyText1: TextStyle(
              fontFamily: ThemeStyle.bodyFont, color: ThemeColors.black100),
          bodyText2: TextStyle(
              fontFamily: ThemeStyle.bodyFont, color: ThemeColors.black100),
          button: ThemeStyle.headerMedium15,
          caption: TextStyle(color: ThemeColors.black100),
          subtitle1: TextStyle(color: ThemeColors.black100),
          subtitle2: TextStyle(color: ThemeColors.black100),
          overline: TextStyle(color: ThemeColors.black100),
        )),
    ThemeType.Dark: ThemeData.dark().copyWith()
  };
}
