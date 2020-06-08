import 'package:flutter/material.dart';

import '../widgets/buttom_navigation_bar.dart';
import 'home.dart';
import 'map.dart';
import 'news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _screens = [
    Home(),
    CMap(),
    //Shops(),
    News()
  ];


  @override
  Widget build(BuildContext context) {
    final MQH = MediaQuery.of(context).size.height;
    final MQW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(height: MQH,width: MQW,margin: const EdgeInsets.only(left: 10, right: 10),child: _screens[_currentIndex]),
          Align(
            alignment: Alignment.bottomCenter,
            child: CButtomNavigationBar(context: context, onSelect: onTabTapped, index: _currentIndex),
          )
        ],
      )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

