import 'package:flutter/material.dart';
import 'package:solution_challenge/localization/keys.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';

import '../res/assets.dart';


class COVIDInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Links.launchURL(Links.COVID_INFO),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
            color: Colors.white,
          ),
          child: LayoutBuilder(
            builder: (_, constrain){
              final constWidth = constrain.maxWidth;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 5.0),
                    width: constWidth * 0.27,
                    height: constWidth * 0.27,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(AssetPath.COVID_IMAGE),
                      ),
                    ),
                  ),
                  Text(PrefManager.tr(context, LocKeys.HOME_COVID_INFO_BTN), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Icon(Icons.navigate_next,color: Theme.of(context).primaryColor,size: 40,),
                ],
              );
            },
          )
      ),
    );
  }

}
