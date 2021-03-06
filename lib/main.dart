import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wondersappver02/implement.dart';
import 'package:wondersappver02/information.dart';
import 'package:provider/provider.dart';
import 'models/inspection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Inspection>(create: (_) => Inspection()),
      ],
      child: MaterialApp(
        title: 'Wonders Inspection App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List _pages = [
    Implement(),
    Information(),
  ];

  @override
  Widget build(BuildContext context) {
    //세로 화면 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
        onWillPop: () => _onBackPressed('종료하시겠습니까?','종료'),
        child: Scaffold(
          body: Center(child: _pages[_selectedIndex]),
          backgroundColor: Colors.blueAccent,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () {
                  _onBackPressed;
                },
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      shape: BoxShape.circle,
                      color: Colors.redAccent),
                  child: Center(child: Text('초기화')),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            height: 60.0,
            color: Colors.white,
            child: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                  primaryColor: Colors.redAccent,
                  bottomAppBarColor: Colors.green,
                  textTheme: Theme.of(context)
                      .textTheme
                      .copyWith(caption: TextStyle(color: Colors.grey))),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: _onItemTapped,
                  currentIndex: _selectedIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.verified_user),
                        title: Text('진단'),
                        backgroundColor: Colors.black),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.perm_device_information),
                      title: Text('휴대폰 정보'),
                    ),
                  ]),
            ),
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBackPressed(txt, selectTxt) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 70.0,
                  child: Center(child: Text(txt)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0)),
                        ),
                        child: Text(
                          '예',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25.0)),
                        ),
                        child: Text(
                          '아니오',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
