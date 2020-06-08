import 'package:flutter/material.dart';
import 'package:solution_challenge/localization/keys.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';
import '../models/advices_list.dart';
import '../screens/advice_details.dart';
import '../widgets/advice_item_design.dart';

class ProtectYourself extends StatelessWidget {
  static const String routeName = "ProtectYourself";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(iconSize: 30,icon: Icon(Icons.arrow_back_ios),color: Theme.of(context).primaryColor,onPressed: (){Navigator.pop(context);},),
        title: Text(PrefManager.tr(context, LocKeys.HOME_PROTECT_YOURSELF_BTN),style: Theme.of(context).textTheme.body1,),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(itemBuilder: (_, index){
          return InkWell(
            onTap: (){Navigator.pushNamed(context, AdviceDetails.routeName, arguments: adviceList[index]);},
              child: AdviceItemDesign(advice: adviceList[index],)
          );
      },
      itemCount: adviceList.length??0,),
    );
  }
}
