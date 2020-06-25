import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart' as Vibrator;

class Vibration extends StatefulWidget{
  @override
  _VibrationState createState() => _VibrationState();
}

class _VibrationState extends State<Vibration> {

  bool _hasVibrator = false;

  @override
  void initState() {
    super.initState();
    initVibrator();
  }

  initVibrator() async {
    bool hasVibrator = await Vibrator.Vibration.hasVibrator();
    print("Device has vibrator ? $hasVibrator");
    setState(() {
      _hasVibrator = hasVibrator;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('진동검사',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Image.asset(
              'images/flash.png',
              width: 400.0,
              height: 250.0,
              fit: BoxFit.contain,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          Text(_hasVibrator ? '' : '진동 기능이 없는 기종입니다.'),
          RaisedButton(
            child: Text('진동'),
            onPressed: () {
              Vibrator.Vibration.vibrate(duration: 1000);
            } ,
          ),
        ],
      ),
    ) ;
  }
}