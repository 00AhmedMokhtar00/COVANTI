import 'package:flutter/material.dart';
import 'package:solution_challenge/screens/chatbot.dart';

class COVANTI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:(_, constrain) {
          final constWidth = constrain.maxWidth;
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width:  constWidth * 0.65,
                height: constWidth * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1, color: Colors.grey, blurRadius: 3)
                    ]
                ),
                child: const Center(child: Text('Hi, I am COVANTI, How can I help you?',
                  style: TextStyle(color: Colors.blue, fontSize: 9,fontWeight: FontWeight.bold),)),
              ),
              GestureDetector(
                  onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) => Chatbot()));},
                  child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),spreadRadius: 1.4, blurRadius: 2)],shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: constrain.maxWidth *0.08,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: constrain.maxWidth *0.125,
                    height: constrain.maxWidth *0.125,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                        image: AssetImage("assets/images/doc.png"),
                      ),
                    ),
                  ),
                ),
              )
              )

            ],
          );
        }
    );
  }
}
