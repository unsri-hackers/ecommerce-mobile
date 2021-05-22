import 'package:deuvox/app/utils/router_utils.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
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
      body: Center(
          child: AnimatedCrossFade(
        crossFadeState: _crossFadeState,
        duration: Duration(milliseconds: 500),
        alignment: Alignment.center,
        firstCurve: Curves.easeIn,
        secondCurve: Curves.easeInOut,
        sizeCurve: Curves.easeIn,
        firstChild: Center(child: CircularProgressIndicator()),
        secondChild: Card(
          margin: EdgeInsets.all(10),
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RouterUtils.uploadItemSCreen);
            },
                      child: Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
              height: 200,
              child: Center(
                child: Text("Welcome",textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
                ),
              )),
          ),
        ),
      )),
    );
  }
}
