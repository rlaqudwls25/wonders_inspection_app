import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:wondersappver02/main.dart';


class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('카메라',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
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
                margin: EdgeInsets.all(50),
                child: Image.asset(
                  'images/camera.png',
                  width: 400.0,
                  height: 250.0,
                  fit: BoxFit.contain,
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              Text('이미지가 선명합니까?',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  FlatButton(
                    child: Text('예',style: TextStyle(fontSize: 16),
                    ),
                    onPressed: (){},
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    child: Text('아니오',style: TextStyle(fontSize: 16),),
                    onPressed: (){},
                    color: Colors.black,
                    textColor: Colors.white,
                  )
                ],
              )
            ],

          ),
        ));
  }
}
