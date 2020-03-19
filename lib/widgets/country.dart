import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  final String country;

  const Country(this.country);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 8),
      child: Text(
        country,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
