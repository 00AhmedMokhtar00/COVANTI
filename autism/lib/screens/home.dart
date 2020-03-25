import 'package:autism/widgets/background.dart';
import 'package:autism/widgets/main_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background('assets/images/background.png'),
          _homeBuilder()
        ],
      ),
    );
  }

  _homeBuilder(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          MainButton(title:'التعريف', img: 'assets/images/1.png'),
          MainButton(title:'الاعراض', img: 'assets/images/2.png'),
          MainButton(title:'الأماكن والمراكز', img: 'assets/images/3.png'),
          MainButton(title:'برنامج العلاج', img: 'assets/images/4.png'),
          MainButton(title:'المشكلات', img: 'assets/images/5.png'),
          MainButton(title:'اسئلة شائعة', img: 'assets/images/6.png'),
        ],
      ),
    );
  }
}

