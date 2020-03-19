import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../widgets/news_item_design.dart';
import '../widgets/title.dart';


class News extends StatelessWidget {
  List<NewsItem> newsList = [
    NewsItem(
      id: 2001,
      title: 'Headline',
      description: '(COVID-19) is an inficious diseas caused by the server acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The diseas has spread globally since 2019'
    ),
  ];
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('News'),
        NewsItemDesign(newsItem: newsList[0],)
      ],
    );
  }
}


