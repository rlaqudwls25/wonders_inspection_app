import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(context, bool) {
  Fluttertoast.showToast(
      msg: "성공!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 18.0);
  if(bool == true){
    Future.delayed(Duration(milliseconds: 2500), () => Navigator.pop(context));
  }
}