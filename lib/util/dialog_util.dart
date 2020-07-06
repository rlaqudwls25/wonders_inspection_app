import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(context, bool, backgroundColor) {
  Fluttertoast.showToast(
      msg: "성공!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 18.0);
  if(bool == true){
    Future.delayed(Duration(milliseconds: 2500), () => Navigator.pop(context));
  }
}

AlertDialog dialogWithFunc(context, title, function1, function2) {
  return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 70.0,
                child: Center(child: Text(title)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () => function1,
                    child: Container(
                      width: 150.0,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0)),
                      ),
                      child: Text(
                        '예',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => function2,
                    child: Container(
                      width: 150.0,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25.0)),
                      ),
                      child: Text(
                        '아니오',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
}