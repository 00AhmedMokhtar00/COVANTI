import 'package:flutter/material.dart';
import '../models/advice.dart';

class AdviceItemDesign extends StatelessWidget {
  AdviceItemDesign({this.advice});
  final Advice advice;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (_, constrain){
            return Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 2.0, top: 4, bottom: 3.0, right: 3.0),
                  width:  constrain.maxWidth * 0.27,
                  height: constrain.maxWidth * 0.27,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(advice.img),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                    Expanded(child: Text(advice.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
                    Icon(Icons.navigate_next,color: Theme.of(context).primaryColor,size: 30),
                    ]
                  ),
                ),
              ],
            );
          },
        )
    );
  }
}
