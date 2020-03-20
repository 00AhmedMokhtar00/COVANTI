import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';
import '../widgets/news_item_design.dart';
import '../widgets/title.dart';


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final int articleId = 0;
  Future<NewsItem> futureNewsItem;
  var offlineData = {
    'title'       : 'Headline',
    'description' : '(COVID-19) is an inficious diseas caused by the server acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The diseas has spread globally since 2019',
    'url'         : '',
    'img'         : 'assets/images/news.png',
  };

  List<NewsItem> newsList = [
    NewsItem(
      title: 'Headline',
      description: '(COVID-19) is an inficious diseas caused by the server acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The diseas has spread globally since 2019'
    ),
  ];

  @override
  void initState() {
    //futureNewsItem = fetchCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('News'),
        newsBuilder(MQ),
      ],
    );
  }

  Widget newsBuilder(MQ){
    return Container(
      width: double.infinity,
      height: MQ * 0.9,
      child: ListView.builder(
        itemBuilder: (_, i){
          futureNewsItem = fetchNewsItem(i);
          return FutureBuilder<NewsItem>(
            future: futureNewsItem,
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return NewsItemDesign(newsItem: NewsItem(title: snapshot.data.title, description: snapshot.data.description, url: snapshot.data.url, img: snapshot.data.img),);
              } else if (snapshot.hasError) {

                return NewsItemDesign(newsItem: NewsItem(title: offlineData['title'], description: offlineData['description'], url: offlineData['url'], img: offlineData['img']));
              }
              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
        itemCount: 19,
      ),
    );
  }

  Future<NewsItem> fetchNewsItem(idx) async {
    final response = await http.get('http://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=ac9e7abdad074d9fbdc65bc32b75afb9');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('newsTitle', body['articles'][idx]['title']);
      prefs.setString('newsDescription', body['articles'][idx]['description']);
      prefs.setString('newsUrl', body['articles'][idx]['url']);
      prefs.setString('newsImg', body['articles'][idx]['urlToImage']);
      return NewsItem.fromJson(json.decode(response.body), idx);
    } else {
      throw Exception('Failed to load cases');
    }
  }
}


