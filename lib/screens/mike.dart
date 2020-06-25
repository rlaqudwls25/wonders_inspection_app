import 'package:flutter/material.dart';
import 'package:wondersappver02/implement.dart';
import 'package:wondersappver02/main.dart';

import 'package:flutter/material.dart';


class Mike extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Network Image',
        theme: ThemeData( primarySwatch: Colors.red ),
        home: Scaffold(
          bottomNavigationBar: Container(
              height: 60,
              child: InkWell(
                onTap: () => print( 'tap on close' ),
                child: Padding(
                  padding: EdgeInsets.only( top: 8.0 ),
                  child: Column(
                      children: <Widget>[
                     RaisedButton(
                       child: Text('실행', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                       onPressed: null,
                     ),
                      ]
                  ),
                ),
              )
          ),
          appBar: AppBar(

            centerTitle: true,
            title: Text( '마이크' ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            leading: IconButton(
              icon: Icon( Icons.arrow_back ),
              onPressed: ()  {

                Navigator.pop(context );
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all( 10 ),
                child: Image.asset( 'images/mike.png',
                  width: 420.0,
                  height: 250.0,
                  fit: BoxFit.contain,
                ),
              ),

              Text1( '1. 이어폰제거' ),
              Text1( '2. 음량 최대' ),
              Text1( '3. 앱에서 마이크 허용' ),
            ],
          ),
        )
    );
  }
  Widget Text1(String text) {
    return Container(
        padding: EdgeInsets.all( 10 ),
        child: Center(
          child: new Text(
            text,
            style: new TextStyle( fontWeight: FontWeight.bold,fontSize: 15.0 ),
          ),
        )
    );
  }


}

