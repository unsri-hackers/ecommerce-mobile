import 'package:flutter/material.dart';

class Utils {
  static Widget circularImage(String path) {
    return ClipOval(
      child: Container(
        child: Image.asset(path),
      ),
    );
  }
}

class TileMenu extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onPressed;
  const TileMenu(
      {Key? key, required this.icon, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onPressed,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: icon),
                Expanded(
                    child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )),
                Container(
                    padding: EdgeInsets.all(16), child: Icon(Icons.chevron_right))
              ],
            ),
          ),
          Divider(indent: 70)
        ],
      ),
    );
  }
}
