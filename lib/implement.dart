import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:wondersappver02/models/inspection.dart';
import 'package:wondersappver02/screens/bluetooth.dart';
import 'package:wondersappver02/screens/camera.dart';
import 'package:wondersappver02/screens/compass.dart';
import 'package:wondersappver02/screens/direction.dart';
import 'package:wondersappver02/screens/flash.dart';
import 'package:wondersappver02/screens/gps.dart';
import 'package:wondersappver02/screens/green.dart';
import 'package:wondersappver02/screens/multitouch.dart';
import 'package:wondersappver02/screens/proximity.dart';
import 'package:wondersappver02/screens/red.dart';
import 'package:wondersappver02/screens/touch.dart';
import 'package:wondersappver02/screens/vibration.dart';
import 'package:wondersappver02/screens/wifi.dart';
import 'package:wondersappver02/screens/blue.dart';
import 'package:wondersappver02/screens/mike.dart';

class Implement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Inspection inspection = Provider.of<Inspection>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wonders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton('마이크', context, Mike(), null),
                  _buildButton('카메라', context, Camera(), null),
                  _buildButton('다중터치', context, Multitouch(),
                      inspection.getMultiTouch()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildButton('터치', context, Touch(), null),
                      _buildButton('방향센서', context, Direction(), null),
                      _buildButton('red', context, Red(), null),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildButton(
                              'Gps', context, Gps(), inspection.getGps()),
                          _buildButton('접근센서', context, Proximity(), null),
                          _buildButton('나침반', context, Compass(), null),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildButton('와이파이', context, Wifi(), null), //X
                              _buildButton('블루투스', context, Bluetooth(), null),
                              _buildButton('blue', context, Blue(), null), //X
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _buildButton('손전등', context, Flash(), null),
                                  _buildButton('green', context, Green(), null),
                                  _buildButton(
                                      '진동검사', context, Vibration(), null),
                                  //X
                                ],
                              ),
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
        ],
      ),
    );
  }

  Widget _buildButton(String text, context, page, String inspectionSuccess) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 120,
      height: 120,
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        color: _buildColor(inspectionSuccess),
        shape: CircleBorder(side: BorderSide(width: 1)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }

  Color _buildColor(String inspectionSuccess) {
    if (inspectionSuccess == 'success') {
      return Colors.cyan;
    } else if (inspectionSuccess == 'fail') {
      return Colors.redAccent;
    } else {
      return Colors.white;
    }
  }
}
