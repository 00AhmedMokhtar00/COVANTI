import 'package:flutter/material.dart';
import 'package:solution_challenge/models/shops_list.dart';
import '../widgets/shop_item_design.dart';

class All extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index){
        return ShopItemDesign(shopItem: shopItem[index]);
      },
      itemCount: shopItem.length??0,
    );
  }
}
