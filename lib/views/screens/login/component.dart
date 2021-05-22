import 'package:deuvox/views/component/common_button.dart';
import 'package:flutter/material.dart';

class Utils {
     static Future<void> showDialogError(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                Text("Silahkan masukkan Username dan Password yang benar"),
                SizedBox(height: 20),
                CButtonFilled(
                  textLabel: "Kembali",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              title: Text(
                "Login Gagal",
                textAlign: TextAlign.center,
              ),
            ));
  }
}