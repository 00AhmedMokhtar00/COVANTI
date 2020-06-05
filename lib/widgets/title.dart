import 'package:flutter/material.dart';


class CTitle extends StatelessWidget {
  CTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}
