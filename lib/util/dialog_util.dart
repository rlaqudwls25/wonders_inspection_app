import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(context) {
  Fluttertoast.showToast(
      msg: "성공!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 18.0);
  Future.delayed(Duration(milliseconds: 2500), () => Navigator.pop(context));
}