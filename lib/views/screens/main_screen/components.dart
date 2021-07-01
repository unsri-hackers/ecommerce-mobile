
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  VoidCallback? onPressed;
  DrawerItem(this.title, this.icon, {this.onPressed});
}