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

  Widget _buildDrawer(BuildContext context) {
    final drawerItems = [
      DrawerItem(LocaleKeys.logout.tr(), Icons.logout, onPressed: () {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content:
                      Text(LocaleKeys.logout_of.tr(args: [AppConfig.appName])),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.cancel.tr(),
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AuthenticationLoggedOutEvent());
                        },
                        child: Text(LocaleKeys.logout.tr(),
                            style: TextStyle(color: Colors.black)))
                  ],
                ));
      }),
      DrawerItem(LocaleKeys.add_product.tr(), Icons.add_shopping_cart_rounded,
          onPressed: () {
        Navigator.pushNamed(context, RouterUtils.uploadItemSCreen);
      })
    ];
    return Drawer(
      child: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                "Jon Doe",
                style: Theme.of(context).textTheme.headline5,
              ),
              accountEmail: Text(
                "Jondoe@deuvox.com",
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(AssetsUtils.userTemp))),
          Column(
              children: drawerItems.map<Widget>((data) {
            return TileMenu(
                icon: Icon(data.icon),
                title: data.title,
                onPressed: data.onPressed);
          }).toList())
        ],
      ),
    );
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
          drawer: _buildDrawer(context),
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
