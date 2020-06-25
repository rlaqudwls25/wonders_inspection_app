import 'package:flutter/material.dart';
import 'package:wondersappver02/implement.dart';
import 'package:wondersappver02/implement.dart';
import 'package:wondersappver02/information.dart';

class TabPage extends StatefulWidget{
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>{
  int _selectedIndex = 0;

  List _pages = [
    Implement(),
    Information(),
    Text('page3'),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: _pages[_selectedIndex],),

      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,

          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Implement')),
            BottomNavigationBarItem(icon: Icon(Icons.perm_device_information), title: Text('Information')),
            BottomNavigationBarItem(icon: Icon(Icons.backup), title: Text('reset')),

          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}