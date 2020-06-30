import 'package:flutter/material.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';



class Touch extends StatefulWidget {
  @override
  TouchState createState() => new TouchState();
}

class TouchState extends State<Touch> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _touch(),
                      _touch(),
                      _touch(),
                      _touch(),
                      _touch(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _touch(),
                          _touch(),
                          _touch(),
                          _touch(),
                          _touch(),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _touch(),
                              _touch(),
                              _touch(),
                              _touch(),
                              _touch(),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _touch(),
                                  _touch(),
                                  _touch(),
                                  _touch(),
                                  _touch(),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _touch(),
                                      _touch(),
                                      _touch(),
                                      _touch(),
                                      _touch(),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                          _touch(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _touch() {
    return Container(
      child: PositionedTapDetector(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0:0.0,
            duration: Duration(microseconds: 500),
            child: Container(
              width: 70.0,
              height: 70.0,
              color: Colors.lightBlueAccent,
            ),
          ),
          onTap: _onTap
      ),
    );
  }

  void _onTap(TapPosition position) => _updateState("single tap", position);

  void _updateState(String gesture, TapPosition position) {
    setState(() {
      _visible =! _visible;

    }
    );
  }

  String _formatOffset(Offset offset) =>
      "${offset.dx.toStringAsFixed(1)}, ${offset.dy.toStringAsFixed(1)}";
}