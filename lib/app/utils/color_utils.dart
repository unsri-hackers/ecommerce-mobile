import 'package:flutter/material.dart';

class ColorUtils {
  static const String gray = '#E0E0E0';
  static const String thumbnail_blue_1 = '#C3D1F6';
  static const String thumbnail_blue_2 = '#AFBEE7';
  static const String thumbnail_blue_3 = '#8DA0D4';
  static const String gray_text = '#696969';
}

class ColorHex extends Color {
  ColorHex(String hex) : super(_getColorFromHex(hex));
  static int _getColorFromHex(String hex) {
    String colorHexReplaced = hex.replaceAll('#', 'FF');
    return int.parse(colorHexReplaced, radix: 16);
  }
}
