import 'package:flutter/material.dart';
import 'package:flashlight/flashlight.dart';

class Flash extends StatefulWidget {
  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  bool _hasFlashlight = false;
  bool _flashOn = false;

  @override
  initState() {
    super.initState();
    initFlashlight();
  }

  initFlashlight() async {
    bool hasFlash = await Flashlight.hasFlashlight;
    print("Device has flash ? $hasFlash");
    setState(() {
      _hasFlashlight = hasFlash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '손전등',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Flashlight.lightOff();
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_flashOn == false) {
                    setState(() {
                      _flashOn = true;
                    });
                    Flashlight.lightOn();
                  } else {
                    setState(() {
                      _flashOn = false;
                    });
                    Flashlight.lightOff();
                  }
                },
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(20),
                    child: Icon(Icons.flash_on, size: 50, color: Colors.white),
                    decoration: BoxDecoration(
                        color: _flashOn == true ? Colors.cyan : Colors.red,
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
                _hasFlashlight ? '손전등 버튼을 눌러보세요.' : '손전등이 없는 기종입니다.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
