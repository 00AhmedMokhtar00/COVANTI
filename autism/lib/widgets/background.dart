import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String img;
  Background(this.img);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
