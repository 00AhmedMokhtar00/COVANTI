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

  };

  List<NewsItem> newsList = [
    NewsItem(
      title: 'Headline',
      description: '(COVID-19) is an inficious diseas caused by the server acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The diseas has spread globally since 2019'
    ),
  ];

  @override
  void initState() {
    futureNewsItem = fetchNewsItem(4);
    getData();
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

                return NewsItemDesign(newsItem: NewsItem(title: offlineData['newsTitle$i'], description: offlineData['newsDescription$i'], url: offlineData['newsUrl$i'], img: offlineData['newsImg$i'])??'yigu');
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

  Future<NewsItem> fetchNewsItem(int i) async {
    final response = await http.get('http://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=323019aaa9fd463e83cce512b425a1ab');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      for(int idx = 0 ; idx <=19 ; idx++) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('newsTitle$idx', body['articles'][idx]['title']);
        prefs.setString(
            'newsDescription$idx', body['articles'][idx]['description']);
        prefs.setString('newsUrl$idx', body['articles'][idx]['url']);
        prefs.setString('newsImg$idx', body['articles'][idx]['urlToImage']);
      }
      return NewsItem.fromJson(json.decode(response.body), i);
    } else {
      throw Exception('Failed to load cases');
    }
  }
  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int idx = 0 ; idx < 19 ; idx++){
      offlineData.addAll(
          {
            'newsTitle$idx': prefs.getString('newsTitle$idx'),
            'newsDescription$idx': prefs.getString('newsDescription$idx'),
            'newsUrl$idx': prefs.getString('newsUrl$idx'),
            'newsImg$idx': prefs.getString('newsImg$idx'),
          }
      );
    }
    setState(() {
      offlineData.addAll(
          {
            'newsTitle19': prefs.getString('newsTitle19'),
            'newsDescription19': prefs.getString('newsDescription19'),
            'newsUrl19': prefs.getString('newsUrl19'),
            'newsImg19': prefs.getString('newsImg19'),
          }
      );

    });
  }
}


