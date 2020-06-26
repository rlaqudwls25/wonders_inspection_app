import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _heading = 0;
  bool isDisposed = false;

  String get _readout => _heading.toStringAsFixed(0) + '°';

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void _onData(double x) {
    if (!isDisposed)
      setState(() {
        _heading = x;
      });
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
                  foregroundPainter: CompassPainter(angle: _heading),
                  child: Center(child: Text(_readout, style: _style)),
                ),
              ),
              Text(
                '스마트폰을 평지에 두고 회전시켜 보세요.',
                style: TextStyle(fontSize: 20),
              ),
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
    Offset end = Offset.lerp(Offset(center.dx, radius), center, -1);

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
