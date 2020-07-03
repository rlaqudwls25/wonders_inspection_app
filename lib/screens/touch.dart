import 'package:flutter/cupertino.dart';
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

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    touch(context),
                    touch(context),
                    touch(context),
                    touch(context),
                    touch(context),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        touch(context),
                        touch(context),
                        touch(context),
                        touch(context),
                        touch(context),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            touch(context),
                            touch(context),
                            touch(context),
                            touch(context),
                            touch(context),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Padding(padding: EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                touch(context),
                                touch(context),
                                touch(context),
                                touch(context),
                                touch(context),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    touch(context),
                                    touch(context),
                                    touch(context),
                                    touch(context),
                                    touch(context),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(1.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        touch(context),
                                        touch(context),
                                        touch(context),
                                        touch(context),
                                        touch(context),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          touch(context),
                                          touch(context),
                                          touch(context),
                                          touch(context),
                                          touch(context),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget touch(BuildContext context){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: (screenWidth - screenPadding) / 4.9,
      height: (screenHeight - screenPadding) / 7.0,
      color: Colors.red,
      child: MyWidget(
        color: cellColor,
      ),
    );
  }

//  void shape(){
//    for(var i=0; i<5; i++){
//      for(var j=0; j<8; j++){
//      }]

//    }
//  }
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
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeCell(widget.index),
      child: Container(
        decoration: BoxDecoration(
          color: cellColor,
        ),
      ),
    );
  }


}
