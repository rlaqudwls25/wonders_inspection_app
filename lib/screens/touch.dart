import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Touch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
        msg: "손가락으로 사각형을 터치하면 사각형이 사라집니다",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 20.0);
    return Center(
      child: Container(
        child: CustomPaint(
          painter: Drawhorizontalline(),
        ),
      ),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 0; i <= 400; i += 54) {
      canvas.drawLine(Offset(-230.0, -i), Offset(230.0, -i), _paint);
      canvas.drawLine(Offset(-230.0, i), Offset(230.0, i), _paint);
      canvas.drawLine(Offset(-i, -330.0), Offset(-i, 330.0), _paint);
      canvas.drawLine(Offset(i, -330.0), Offset(i, 330.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
