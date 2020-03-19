import 'package:flutter/material.dart';

class CTab extends StatelessWidget {
  final String title;
  final Color color;
  CTab({this.title, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color,
        //color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5)]
      ),
      child: Center(child: FittedBox(child: Text(title))),
    );
  }
}
