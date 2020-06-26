import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart' as Vibrator;

class Vibration extends StatefulWidget {
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
        title: Text(
          '진동검사',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Vibrator.Vibration.vibrate(duration: 1000);
            },
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(20),
                child: Icon(Icons.vibration, size: 50, color: Colors.white),
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          Text(
            _hasVibrator ? '진동 버튼을 눌러보세요.' : '진동 기능이 없는 기종입니다.',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
