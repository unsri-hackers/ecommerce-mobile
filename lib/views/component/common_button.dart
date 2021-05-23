import 'package:flutter/material.dart';

///Styled Button that already fully customized
class CButtonFilled extends StatelessWidget {
  /// Primary Text for Button
  final String textLabel;
  /// onPressed event, set as null to disabled
  final VoidCallback? onPressed;
  /// Show Button without pressed event and using CircularProgressIndicator. 
  /// Default: `false`
  final bool isLoading;
  /// Show button with rounded border instead of Squared
  /// Default: `false`
  final bool rounded;
  /// Use this to add left icon in the button
  final Icon? icon;
  /// Override Button Primary Color. Default will use MaterialApp Styles
  final Color? primaryColor;
  const CButtonFilled(
      {Key? key,
      this.onPressed,
      required this.textLabel,
      this.isLoading = false,
      this.icon,
      this.rounded = false,
      this.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = rounded
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        : RoundedRectangleBorder();
    return Container(
      height: 44,
      child: isLoading
          ? ElevatedButton(
              onPressed: null,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).backgroundColor)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(shape),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return (primaryColor ??
                              Theme.of(context).colorScheme.primary)
                          .withOpacity(0.5);
                    else if (states.contains(MaterialState.disabled))
                      return primaryColor ?? Theme.of(context).primaryColor;
                    return Theme.of(context)
                        .primaryColor; // Use the component's default.
                  },
                ),
              ),
            )
          : icon != null
              ? ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: icon!,
                  label: Text(textLabel),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Theme.of(context).disabledColor;
                      else
                        return primaryColor ?? Theme.of(context).primaryColor;
                    }),
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        shape),
                  ))
              : ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Theme.of(context).disabledColor;
                      else
                        return primaryColor ?? Theme.of(context).primaryColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        shape),
                  ),
                  onPressed: onPressed,
                  child: Text(textLabel),
                ),
    );
  }
}
