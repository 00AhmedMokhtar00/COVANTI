import 'package:flutter/material.dart';
import '../../models/shops_list.dart';
import '../../widgets/shop_item_design.dart';

class Pharmacies extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height * 0.7;
    return Container(
      width: double.infinity,
      height: MQ,
      child: ListView.builder(
        itemBuilder: (_, index) {
          if(shopItem.isNotEmpty){
            return ShopItemDesign(shopItem: shopItem[index]);
          }else{
            return Center(child: Text('SOON!',style: TextStyle(color: Colors.red.withOpacity(0.7),fontSize: 25),),);
          }
          },
        itemCount: shopItem.length == 0? 1: shopItem.length,
      ),
    );
  }
}
