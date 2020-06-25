import 'package:flutter/material.dart';

class Proximity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'images/proximity.png',
                  width: 400.0,
                  height: 250.0,
                  fit: BoxFit.contain,
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 50.0)),
              Text('손으로 휴대폰 위를 가려보세요',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
            ],
          ),
        ));
  }
}
