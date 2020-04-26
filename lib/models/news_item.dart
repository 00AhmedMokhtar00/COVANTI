import 'package:flutter/cupertino.dart';

class NewsItem{
  //final int id;
  final String  title, img, description, url;
  const NewsItem({@required this.url, @required this.description,@required this.title,this.img});

  factory NewsItem.fromJson(Map<String, dynamic> json, int idx) {
    return NewsItem(
      title: json['articles'][idx]['title'],
      description: json['articles'][idx]['description'],
      url: json['articles'][idx]['url'],
      img: json['articles'][idx]['urlToImage'],
    );
  }
}