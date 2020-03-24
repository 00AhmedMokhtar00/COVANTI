import 'package:flutter/material.dart';
import 'package:solution_challenge/models/shops_list.dart';
import '../widgets/shop_item_design.dart';

class All extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index){
        if(shopItem.isNotEmpty && shopItem[index].type == 'P') {
          return shopItem[index].type == 'P' ? ShopItemDesign(shopItem: shopItem[index]) : Container();
        }else{
          return Center(child: Text('SOON!',style: TextStyle(color: Colors.red.withOpacity(0.7),fontSize: 25),),);
        }
      },
      itemCount: shopItem.length == 0? 1: shopItem.length,
    );
  }
}
