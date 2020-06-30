import "package:flutter/material.dart";
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
                  _buildButton('마이크',context,Mike()),
                  _buildButton('카메라',context,Camera()),
                  _buildButton('다중터치',context,Multitouch()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildButton('터치',context,Touch()),
                      _buildButton('방향센서',context,Direction()),
                      _buildButton('red',context,Red()), //X
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildButton('Gps' ,context, Gps()), //X
                          _buildButton('접근센서' ,context,Proximity()),
                          _buildButton('나침반',context,Compass()),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildButton('와이파이',context,Wifi()), //X
                              _buildButton('블루투스',context,Bluetooth()),
                              _buildButton('blue',context,Blue()), //X
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _buildButton('손전등',context,Flash()),
                                  _buildButton('green',context,Green()),
                                  _buildButton('진동검사',context,Vibration()), //X
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

  Widget _buildButton(String text, context, page) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 120,
      height: 120,
      alignment: Alignment.center,
      child: new RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page)
          );
        },
        shape: CircleBorder(side: BorderSide(width: 1)),
        child: new Center(
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
}