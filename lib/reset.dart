import 'package:flutter/material.dart';
import 'package:wondersappver02/main.dart';


class Reset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    child: Text('예', style: TextStyle(color: Colors.white,fontSize: 16)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    child: Text("아니오", style: TextStyle(color: Colors.white,fontSize: 16)),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
