import 'package:flutter/material.dart';

class Gps extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Gps',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        )
    );
  }
}
