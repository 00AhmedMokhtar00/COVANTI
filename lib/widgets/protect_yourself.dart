import 'package:flutter/material.dart';
import '../screens/protect_yourself.dart';

class ProtectYourselfButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProtectYourself()));},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: MQ * 0.06,
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
