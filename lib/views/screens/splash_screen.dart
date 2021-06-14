import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:  Theme.of(context).primaryColor,
        child: Center(
          child: Image.asset(AssetsUtils.logo,
          scale: 0.8,
          ),
        ),
      ),
    );
  }
}