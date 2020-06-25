import 'package:flutter/material.dart';

class Bluetooth extends StatelessWidget {
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
                    child: Column(
                        children: <Widget>[
                      RaisedButton(
                          child: Text('실행', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                          onPressed: null)
                          ,
                    ]
                    ),
                  ),
                )),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '블루투스',
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
            body: Container(
              margin: EdgeInsets.all(90.0),
              child: Text(
                '블루투스의 기능을 실행합니다.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            )));
  }
}
