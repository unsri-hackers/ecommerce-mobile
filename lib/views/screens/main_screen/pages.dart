import 'package:deuvox/app/config/app_config.dart';
import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/app/utils/router_utils.dart';
import 'package:deuvox/controller/bloc/authentication/authentication_bloc.dart';
import 'package:deuvox/generated/lang_utils.dart';
import 'package:deuvox/views/screens/home_screen/pages.dart';
import 'package:deuvox/views/screens/orders_screen/pages.dart';
import 'package:deuvox/views/screens/profile_screen/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomeScreen(
        scaffoldKey: _scaffoldKey,
      ),
      OrdersScreen(),
      ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        }
        return true;
      },
      child: DefaultTabController(
        length: _listPage.length,
        initialIndex: _selectedIndex,
        child: Scaffold(
          key: _scaffoldKey,
          body: PageView(children: _listPage, controller: _pageController),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: LocaleKeys.home.tr(),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AssetsUtils.order)),
                label: LocaleKeys.orders.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: LocaleKeys.profile.tr(),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() {
              _selectedIndex = value;
              _pageController!.animateToPage(_selectedIndex,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
          ),
        ),
      ),
    );
  }
}
