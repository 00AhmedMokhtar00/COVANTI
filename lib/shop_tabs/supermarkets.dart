import 'package:flutter/material.dart';
import '../models/shops_list.dart';
import '../widgets/shop_item_design.dart';

class SuperMarkets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height * 0.7;
    return Container(
      width: double.infinity,
      height: MQ,
      child: ListView.builder(
        itemBuilder: (_, index) {
          if(shopItem[index].type == 'S')
            return ShopItemDesign(shopItem: shopItem[index]);
          else
            return Container();
        },
        itemCount: shopItem.length??0,
      ),
    );
  }
}
