import 'package:flutter/material.dart';
import 'package:solution_challenge/localization/keys.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';

import '../res/asset_paths.dart';
import '../screens/chatbot.dart';

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
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width:  constWidth * 0.68,
                height: constWidth * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1, color: Colors.grey, blurRadius: 3)
                    ]
                ),
                child: Center(child: Text(PrefManager.tr(context, LocKeys.HOME_COVANTI_MSG),
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 9.5,fontWeight: FontWeight.bold),)),
              ),
              GestureDetector(
                  onTap: (){Navigator.pushNamed(context, Chatbot.routeName);},
                  child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),spreadRadius: 1.4, blurRadius: 2)],shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: constrain.maxWidth *0.1,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        image: AssetImage(AssetPath.COVANTI_IMAGE),
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
