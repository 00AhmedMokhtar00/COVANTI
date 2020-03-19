import 'package:flutter/material.dart';
import '../models/shops_list.dart';
import 'package:solution_challenge/widgets/shop_item_design.dart';

class Pharmacies extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height * 0.7;
    return Container(
      width: double.infinity,
      height: MQ,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return shopItem[index].type == 'P'?ShopItemDesign(shopItem: shopItem[index]):Container();
          },
        itemCount: shopItem.length??0,
      ),
    );
  }
}
