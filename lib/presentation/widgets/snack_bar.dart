import 'package:flutter/material.dart';

class SnackBarInfo {
  SnackBarInfo.show(
      {required BuildContext context,
      required String message,
      required bool isSuccess}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isSuccess
          ? const Color.fromRGBO(15, 202, 122, 1)
          : Theme.of(context).errorColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
