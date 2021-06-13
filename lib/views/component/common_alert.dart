import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CAlert extends StatelessWidget {
  final String imagePath;
  final String message;

  CAlert({required this.imagePath, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(this.imagePath),
              Container(
                child: Text(
                  this.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LouisGeorgeCafe',
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
