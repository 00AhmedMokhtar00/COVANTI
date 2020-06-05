import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220.0,
        height: 60.0,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color(0xff153E87),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [BoxShadow(color: Colors.grey)]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircularProgressIndicator(backgroundColor: Colors.grey),
            Expanded(child: Text('Fetching data ...', textAlign: TextAlign.end, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),))
          ],
        ),
      ),
    );
  }
}
