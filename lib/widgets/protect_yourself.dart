import 'package:flutter/material.dart';
import '../screens/protect_yourself.dart';

class ProtectYourselfButton extends StatelessWidget {
  const ProtectYourselfButton();
  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: (){Navigator.pushNamed(context, ProtectYourself.routeName);},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
        width: MQ.width,
        height: MQ.height * 0.07,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(blurRadius: 3)]
        ),
        child: const Center(child: Text('Protect yourself',style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}
