import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/news_item.dart';
import '../widgets/news_item_design.dart';
import '../widgets/title.dart';

class News extends StatelessWidget {
  final String countryCode;
  Future<Map<String, String>> offlineData;

  News(this.countryCode) {
    offlineData = getData();
  }

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('News'),
        Expanded(child: newsBuilder(MQ)),
        SizedBox(height: 30,)
      ],
    );
  }

  Widget newsBuilder(MQ) {
    return Container(
      width: double.infinity,
      child: FutureBuilder<Map<String, String>>(
          future: offlineData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) {
                  if (i == 19) {
                    return SizedBox(
                      height: 80,
                    );
                  }
                  return NewsItemDesign(
                    newsItem: NewsItem(
                        title: snapshot.data['newsTitle$i'],
                        description: snapshot.data['newsDescription$i'],
                        url: snapshot.data['newsUrl$i'],
                        img: snapshot.data['newsImg$i']),
                  );
                  // By default, show a loading spinner.
                },
                itemCount: 20,
              );
            }else if(snapshot.hasError){
              return Center(child: Text('Please enable internet to get the latest news', style: TextStyle(color: Colors.red, fontSize: 15, height: 1.4),));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<Map<String, String>> getData() async {
    try {
      await fetchNews();
    } catch (e) {} finally {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> temp = {};
      for (int idx = 0; idx <= 19; idx++) {
        temp.addAll({
          'newsTitle$idx': prefs.getString('newsTitle$idx') ?? ' ',
          'newsDescription$idx': prefs.getString('newsDescription$idx') ?? ' ',
          'newsUrl$idx': prefs.getString('newsUrl$idx') ?? ' ',
          'newsImg$idx': prefs.getString('newsImg$idx') ?? ' ',
        });
      }
      return temp;
    }
  }

  Future<NewsItem> fetchNews() async {
    final response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=$countryCode&category=health&apiKey=323019aaa9fd463e83cce512b425a1ab');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      for (int idx = 0; idx <= 19; idx++) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('newsTitle$idx', body['articles'][idx]['title']);
        prefs.setString(
            'newsDescription$idx', body['articles'][idx]['description']);
        prefs.setString('newsUrl$idx', body['articles'][idx]['url']);
        prefs.setString('newsImg$idx', body['articles'][idx]['urlToImage']);
      }
    }
  }
}
