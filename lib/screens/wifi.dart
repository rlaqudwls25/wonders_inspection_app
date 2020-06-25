import 'package:flutter/material.dart';

class Wifi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Wifi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.black,
    ) ;
  }
}