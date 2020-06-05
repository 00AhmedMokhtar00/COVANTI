import 'package:flutter/material.dart';

import '../models/shop_item.dart';

class ShopItemDesign extends StatelessWidget {
  ShopItemDesign({@required this.shopItem});
  final ShopItem shopItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (_, constrain){
            final constWidth = constrain.maxWidth;
            return Row(

              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  width: constWidth * 0.27,
                  height: constWidth * 0.27,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(shopItem.img),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(shopItem.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      const SizedBox(height: 6,),
                      Text(shopItem.description, style: TextStyle(fontSize: 10,)),
                      shopItem.available?
                      Align(alignment: Alignment.bottomLeft,child: FittedBox(child: FlatButton.icon(icon: Image.asset('assets/icons/truei.png',width: 20,height: 20,), label: Text('supplies available',style: TextStyle(fontSize: 12),),)))
                          :FittedBox(child: FlatButton.icon(icon: Image.asset('assets/icons/falsei.png',width: 20,height: 20,), label: Text('supplies unavailable',style: TextStyle(fontSize: 12)),)),
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
