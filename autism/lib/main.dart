import'package:flutter/material.dart';

import 'screens/home.dart';

void main() => runApp(Autism());

class Autism extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Autism',
        theme: ThemeData(
          fontFamily: 'Almarai',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold)
          )
        ),
        home: HomePage(),
      ),
    );
  }
}
