import 'package:flutter/material.dart';

class Direction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '방향 센서',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop((context));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(60.0),
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
                  touch1(''),
                ],
              ),
              new Padding(padding: EdgeInsets.only(top: 15.0)),
              Text(
                '핸드폰을 기울여 빨간색 원을 하얀색 원에 넣으세요',
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
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }

  Widget touch1(String text1) {
    return Container(
      margin: EdgeInsets.all(40.0),
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }
}