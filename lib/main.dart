import 'package:flutter/material.dart';
import 'package:bidirectional_listview/bidirectional_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:wondersappver02/implement.dart';
import 'package:wondersappver02/information.dart';
import 'package:wondersappver02/reset.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Wonders '

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const MethodChannel _channel =
  const MethodChannel('com.example.wondersver1');

  String _platformVersion = 'Unknown';

  Future<String> getPlatformVersion() async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  int _selectedIndex = 0;

  List _pages = [
    Implement(),
    Information(),
    Reset(),
  ];

  @override
  Widget build(BuildContext context){
    //세로 화면 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(

          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[


            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('진단')),
            BottomNavigationBarItem(icon: Icon(Icons.perm_device_information), title: Text('휴대폰 정보')),
            BottomNavigationBarItem(icon: Icon(Icons.backup), title: Text('초기화')),
          ]),
    );

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
