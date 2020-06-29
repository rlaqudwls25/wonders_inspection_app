import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Multitouch extends StatefulWidget {
  @override
  _MultitouchState createState() => _MultitouchState();
}

class _MultitouchState extends State<Multitouch> {
  bool firstCircleClicked = false;
  bool secondCircleClicked = false;

  double firstCircleTop = Random().nextInt(200).toDouble() + 50;
  double firstCircleLeft = Random().nextInt(50).toDouble() + 50;
  double firstCircleWidth = Random().nextInt(50).toDouble() + 50;
  double firstCircleHeight = Random().nextInt(50).toDouble() + 50;

  double secondCircleTop = Random().nextInt(200).toDouble() + 50;
  double secondCircleRight = Random().nextInt(50).toDouble() + 50;
  double secondCircleWidth = Random().nextInt(50).toDouble() + 70;
  double secondCircleHeight = Random().nextInt(50).toDouble() + 70;

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
                  },
                  onTapUp: (TapUpDetails tu) {
                    setState(() {
                      firstCircleClicked = false;
                    });
                  },
                  onTapCancel: (){
                    setState(() {
                      firstCircleClicked = false;
                    });
                  },
                  child: Container(
                    width: firstCircleWidth,
                    height: firstCircleHeight,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 1.0),
                      color: firstCircleClicked ? Colors.blue : Colors.white,
                    ),

                  ),
                ),
              ),
              Positioned(
                top: secondCircleTop,
                right: secondCircleRight,
                child: GestureDetector(
                  onTapDown: (TapDownDetails td){
                    setState(() {
                      secondCircleClicked = true;
                    });
                  },
                  onTapUp: (TapUpDetails tu){
                    setState(() {
                      secondCircleClicked = false;
                    });
                  },
                  onTapCancel: (){
                    setState(() {
                      secondCircleClicked = false;
                    });
                  },
                  child: Container(
                    width: secondCircleWidth,
                    height: secondCircleHeight,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 1.0),
                      color: secondCircleClicked ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Text(
                  '손가락을 이용하여 화면 상의 '
                  '두 원을 동시에 눌러주세요',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          )),
    );
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
