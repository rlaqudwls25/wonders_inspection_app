import 'package:flutter/material.dart';
import 'package:flashlight/flashlight.dart';

class Flash extends StatefulWidget {
  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {

  bool _hasFlashlight = false;

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
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
          bottomNavigationBar: Container(
              height: 60.0,
              child: InkWell(
                onTap: () => print('tap on close'),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(children: <Widget>[
                  ]),
                ),
              )),
          appBar: AppBar(
            centerTitle: true,
            title: Text('손전등', style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Flashlight.lightOff();
                Navigator.pop(context);
              },
            ),
          ),
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
              Text(_hasFlashlight ? '' : '손전등이 없는 기종입니다.'),
              RaisedButton(
                child: Text('켜기'),
                onPressed: () => Flashlight.lightOn(),
              ),
              RaisedButton(
                child: Text('끄기'),
                onPressed: () => Flashlight.lightOff(),
              )
            ],
          ),
        ));
  }
}