import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sensor_compass/flutter_sensor_compass.dart' as nCompass;
import 'package:provider/provider.dart';
import 'package:wondersappver02/models/inspection.dart';

import 'package:wondersappver02/util/dialog_util.dart' as dialogUtil;

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _degrees = 0;
  StreamSubscription _compassSubscription;
  final int randomNum = Random().nextInt(360);

  String get _readout => _degrees.toStringAsFixed(0) + '°';

  @override
  void initState() {
    _startCompass();
    super.initState();
  }

  void _startCompass() {
    if (_compassSubscription != null) return;
    _compassSubscription = nCompass.Compass().compassUpdates(interval: Duration(milliseconds: 20)).listen((value) {
      if (this.mounted) {
        setState(() {
          _degrees = value;
        });
        if(randomNum.toString() == _degrees.toStringAsFixed(0)){
          _stopCompass();
          dialogUtil.showToast(context);
          Provider.of<Inspection>(context).setCompass('success');
          Navigator.pop(context);
        }
      }
    });
  }

  void _stopCompass() {
    if (_compassSubscription == null) return;
    _compassSubscription.cancel();
    _compassSubscription = null;
  }

  final TextStyle _style = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '나침반',
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
          body: Column(
            children: <Widget>[
              Expanded(
                child: CustomPaint(
                  foregroundPainter: CompassPainter(angle: _degrees),
                  child: Center(child: Text(_readout, style: _style)),
                ),
              ),
              Text('스마트폰을 평지에 두고', style: TextStyle(fontSize: 20)),
              Text('각도를 ${this.randomNum}°에 맞춰보세요.',style: TextStyle(fontSize: 20)),
              SizedBox(height: 80)
            ],
          ),
        ));
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({@required this.angle}) : super();

  final double angle;

  double get rotation => -2 * pi * (angle / 360);

  Paint get _brush => new Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush..color = Colors.black.withOpacity(0.6);
    Paint needle = _brush..color = Colors.red[400];

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset start = Offset.lerp(Offset(center.dx, radius), center, 0.1);
    Offset end = Offset.lerp(Offset(center.dx, radius), center, -0.1);

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
