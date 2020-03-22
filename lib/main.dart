import 'package:flutter/material.dart';

import 'screens/home_page.dart';

main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVANTI',
      theme: ThemeData(
        fontFamily: 'SFUIText',
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.black,fontSize: 28, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16, color: Colors.black), // Default
            bodyText1: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.75),fontWeight: FontWeight.bold), // bottomNavigationBar

        ),
        primarySwatch: Colors.blue
      ),
      home: HomePage()
    );
  }


}
