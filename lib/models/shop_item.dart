import 'package:flutter/cupertino.dart';

class ShopItem{
  final int id;
  final String type, name, img, description;
  final bool available;
  const ShopItem({@required this.id, @required this.description,@required this.name,this.img = 'assets/images/img.png',@required this.type, this.available = true});
}