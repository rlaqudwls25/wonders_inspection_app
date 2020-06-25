import 'package:flutter/material.dart';

class Flash extends StatelessWidget {
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
                    RaisedButton(
                        child: Text('실행', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                        onPressed: null)
                    ,
                  ]),
                ),
              )),
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
              new Padding(padding: EdgeInsets.only(top: 50.0)),
              Text('손전등 기능이 작동됩니다',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
            ],
          ),
        ));
  }
}
