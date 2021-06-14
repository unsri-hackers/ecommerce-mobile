import 'package:deuvox/app/utils/assets_utils.dart';
import 'package:flutter/material.dart';

import 'common_button.dart';
import 'curve_clipper.dart';

/// Placeholder Widget shared across any screen
class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(
      {Key? key,
      this.imagePath,
      required this.title,
      this.subtitle,
      this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.fullWidthButton = false,
      this.buttonText})
      : assert(onPressed != null && buttonText != null),
        super(key: key);

  /// Optional asset Path Image. Use `AssetsUtils` to get right Asset Path
  final String? imagePath;

  /// Optional Subtitle/description placeholder
  final String? subtitle;
  final String title;

  /// Add onPressed Method will show Button
  final VoidCallback? onPressed;

  /// It can't be empty if onPress is not null
  final String? buttonText;
  final MainAxisAlignment mainAxisAlignment;
  final bool fullWidthButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (imagePath != null)
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Image.asset(
                  imagePath!,
                  height: 200,
                )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (subtitle != null) SizedBox(height: 8),
          if (subtitle != null)
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 14),
                )),
          SizedBox(height: 15),
          onPressed != null
              ? fullWidthButton
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      child: CButtonFilled(
                          rounded: true,
                          textLabel: buttonText!,
                          onPressed: onPressed!),
                    )
                  : CButtonFilled(
                      rounded: true,
                      textLabel: buttonText!,
                      onPressed: onPressed!)
              : Container()
        ],
      ),
    );
  }
}

class CurveHeader extends StatelessWidget {
  final String imgAssetPlaceholder;
  const CurveHeader({Key? key,required this.imgAssetPlaceholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: 250,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 29, top: 28),
            child: Image.asset(AssetsUtils.logo),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 48),
              child: Image.asset(imgAssetPlaceholder),
            ),
          ),
        ],
      ),
    );
  }
}
