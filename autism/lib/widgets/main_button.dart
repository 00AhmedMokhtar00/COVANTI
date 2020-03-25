import 'package:autism/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainButton extends StatelessWidget {
  final String title, img;

  MainButton({this.title, this.img});

  @override
  Widget build(BuildContext context) {
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MQW,
      height: MQH * 0.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
          children: <Widget>[
            Background(img),
            Container(margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),child: Align(alignment: Alignment.bottomRight, child: Text(title, style: Theme.of(context).textTheme.headline1,)))
          ],
        ),
    );
  }
}
