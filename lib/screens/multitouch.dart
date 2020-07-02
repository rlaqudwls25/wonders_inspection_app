import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wondersappver02/models/inspection.dart';

class Multitouch extends StatefulWidget {
  @override
  _MultitouchState createState() => _MultitouchState();
}

class _MultitouchState extends State<Multitouch> {
  bool firstCircleClicked = false;
  bool secondCircleClicked = false;

  final double firstCircleTop = Random().nextInt(200).toDouble() + 50;
  final double firstCircleLeft = Random().nextInt(50).toDouble() + 50;
  final double firstCircleWidth = Random().nextInt(50).toDouble() + 50;
  final double firstCircleHeight = Random().nextInt(50).toDouble() + 50;
  final double secondCircleTop = Random().nextInt(200).toDouble() + 50;
  final double secondCircleRight = Random().nextInt(50).toDouble() + 50;
  final double secondCircleWidth = Random().nextInt(50).toDouble() + 70;
  final double secondCircleHeight = Random().nextInt(50).toDouble() + 70;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '다중 터치',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: firstCircleTop,
                left: firstCircleLeft,
                child: GestureDetector(
                  onTapDown: (TapDownDetails td) {
                    setState(() {
                      firstCircleClicked = true;
                    });
                    if (firstCircleClicked == true &&
                        secondCircleClicked == true) {
                      Provider.of<Inspection>(context).setMultiTouch('success');
                      showToast(context);
                    }
                  },
                  onTapUp: (TapUpDetails tu) {
                    setState(() {
                      firstCircleClicked = false;
                    });
                    firstCircleClicked = false;
                  },
                  onTapCancel: () {
                    setState(() {
                      firstCircleClicked = false;
                    });
                    firstCircleClicked = false;
                  },
                  child: Container(
                    width: firstCircleWidth,
                    height: firstCircleHeight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(4.0, 4.0),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 1.0),
                      color:
                          firstCircleClicked ? Colors.redAccent : Colors.white,
                    ),
//                      ),
                  ),
                ),
              ),
              Positioned(
                top: secondCircleTop,
                right: secondCircleRight,
                child: GestureDetector(
                  onTapDown: (TapDownDetails td) {
                    setState(() {
                      secondCircleClicked = true;
                    });
                    if (secondCircleClicked == true &&
                        firstCircleClicked == true) {
                      Provider.of<Inspection>(context).setMultiTouch('success');
                      showToast(context);
                    }
                  },
                  onTapUp: (TapUpDetails tu) {
                    setState(() {
                      secondCircleClicked = false;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      secondCircleClicked = false;
                    });
                  },
                  child: Container(
                    width: secondCircleWidth,
                    height: secondCircleHeight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(4.0, 4.0),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 1.0),
                      color:
                          secondCircleClicked ? Colors.redAccent : Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Text(
                  '화면 상의 두 원을 동시에 눌러주세요.',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          )),
    );
  }

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

  Widget touch(String text) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 90.0,
      width: 90.0,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }

}
