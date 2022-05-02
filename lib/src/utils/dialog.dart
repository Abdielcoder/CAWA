import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static void show(BuildContext context, String title, String desc) {
    if (context == null) return;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      },
    )..show();
  }
  }