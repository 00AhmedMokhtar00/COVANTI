import 'package:flutter/cupertino.dart';

class NewsItem{
  final int id;
  final String  title, img, description;
  const NewsItem({@required this.id, @required this.description,@required this.title,this.img = 'assets/images/news.png'});
}