import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Multitouch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '다중 터치',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(30.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  touch(''),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  touch(''),
                ],
              ),
              new Padding(padding: EdgeInsets.only(top: 15.0)),
              Text(
                '손가락을 이용하여 화면 상의 '
                    '두 원을 동시에 눌러주세요',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget touch(String text) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 90.0,
      width: 90.0,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }
}
