import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:proximity_plugin/proximity_plugin.dart';
import 'package:wondersappver02/models/inspection.dart';

class Proximity extends StatefulWidget {
  @override
  _ProximityState createState() => _ProximityState();
}

class _ProximityState extends State<Proximity> {
  String _proximity;
  Timer timer;
  int count = 0;

  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    _streamSubscriptions.add(proximityEvents.listen((ProximityEvent event) {
      if (this.mounted) {
        setState(() {
          _proximity = event.x;
        });
      }
    }));

    timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      if (count > 3) {
        pauseTimer();
        Provider.of<Inspection>(context).setProximity('success');
        showToast(context);
      } else {
        if(_proximity == 'Yes'){
          setState(() {
            count += 1;
          });
        }
      }
    });
  }

  void showToast(context) {
    Fluttertoast.showToast(
        msg: "성공!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 18.0);
    Future.delayed(Duration(milliseconds: 2500), () => Navigator.pop(context));
  }

  pauseTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '접근 센서',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(20),
                  child: Icon(Icons.flash_on, size: 50, color: Colors.white),
                  decoration: BoxDecoration(
                      color: _proximity == 'Yes' ? Colors.cyan : Colors.red,
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
              SizedBox(height: 70),
              Text('손으로 휴대폰 위를 1초동안 가려보세요.', style: TextStyle(fontSize: 17.0))
            ],
          ),
        ));
  }
}
