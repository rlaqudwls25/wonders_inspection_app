import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Touch extends StatefulWidget {
  @override
  _TouchState createState() => new _TouchState();
}

class _TouchState extends State<Touch> {
  Color cellColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
        msg: "손가락으로 사각형을 터치하면 색깔이 바뀝니다",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15.0);
    return Scaffold(
      body: Container(
        child: GridView.count(
          crossAxisCount: 5,
          children: List.generate(45, (index) {
            return MyWidget(
              index: index,
              color: cellColor,
            );
          }),
        ),
      ),

    );

  }
}

class MyWidget extends StatefulWidget {
  final Color color;
  final int index;

  MyWidget({this.color, this.index});

  @override
  _MyWidgetState createState() => new _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Color cellColor = Colors.black;

  @override
  void initState() {
    super.initState();
    cellColor = widget.color;
  }

  _changeCell(index) {
    setState(() {
      switch (index) {
        case 0:
          cellColor = Colors.red;
          break;
        case 1:
          cellColor = Colors.red;
          break;
        case 2:
          cellColor = Colors.red;
          break;
        case 3:
          cellColor = Colors.red;
          break;
        case 4:
          cellColor = Colors.red;
          break;
        default:
          cellColor = Colors.red;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeCell(widget.index),
      child: Container(
        margin: EdgeInsets.all(3.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: cellColor,
        ),
      ),
    );
  }
}