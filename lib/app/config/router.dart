import 'package:deuvox/views/screens/upload_screen/pages.dart';
import 'package:deuvox/views/screens/main_screen/pages.dart';

import '../../views/screens/login/pages.dart';
import '../utils/router_utils.dart';
import '../../views/screens/err404_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Routes Configuration and Management
class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterUtils.welcomeScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case RouterUtils.loginScreen:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: routeSettings);
      case RouterUtils.uploadItemSCreen:
        return MaterialPageRoute(
            builder: (_) => UploadScreen(), settings: routeSettings);

      default: //redirect to appinfoview
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
                Err404Screen());
    }
  }
}
