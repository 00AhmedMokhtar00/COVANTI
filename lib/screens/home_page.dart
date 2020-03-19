import 'package:flutter/material.dart';
import '../screens/shops.dart';
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
  final List<Widget> _screens = [
    Home(),
    CMap(),
    Shops(),
    News()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(width: double.infinity,margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),child: _screens[_currentIndex]),
              Container(height: 100,width: double.infinity,)
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CButtomNavigationBar(onSelect: onTabTapped, index: _currentIndex),
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

