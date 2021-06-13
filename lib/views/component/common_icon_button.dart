import 'package:flutter/material.dart';

class CIconButton extends StatelessWidget {
  final Icon? icon;
  final ImageIcon? imageIcon;
  final VoidCallback onPress;

  CIconButton({
    this.icon,
    this.imageIcon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPress,
      child: imageIcon != null
          ? imageIcon
          : icon != null
              ? icon
              : Container(),
    );
  }
}
