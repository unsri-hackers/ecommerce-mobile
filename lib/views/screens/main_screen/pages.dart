import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:deuvox/app/utils/router_utils.dart';
import 'package:deuvox/views/screens/home_screen/pages.dart';
import 'package:deuvox/views/screens/orders_screen/pages.dart';
import 'package:deuvox/views/screens/profile_screen/pages.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomeScreen _homeScreen = HomeScreen();
  final OrdersScreen _ordersScreen = OrdersScreen();
  final ProfileScreen _profileScreen = ProfileScreen();
  List<Widget> _screens = [];
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  int _selectedIndexMainScreen = 0;
  @override
  void initState() {
    _screens = [
      _homeScreen,
      _ordersScreen,
      _profileScreen,
    ];
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      if (mounted) {
        setState(() {
          _crossFadeState = CrossFadeState.showSecond;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: this._screens[this._selectedIndexMainScreen]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsUtils.order)),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: this._selectedIndexMainScreen,
        onTap: (value) => setState(() => this._selectedIndexMainScreen = value),
      ),
    );
  }
}
