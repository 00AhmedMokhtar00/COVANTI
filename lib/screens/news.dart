import 'package:flutter/material.dart';

import '../prefs/pref_manager.dart';
import '../models/news_item.dart';
import '../widgets/news_item_design.dart';
import '../widgets/title.dart';

class News extends StatelessWidget {
  static const String routeName = "News";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('News'),
        Expanded(child: newsBuilder()),
        SizedBox(height: 30)
      ],
    );
  }

  Widget newsBuilder() {
    return Container(
      width: double.infinity,
      child: FutureBuilder<Map<String, String>>(
          future: PrefManager.getOfflineNews(),
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
            }
            return Center(child: Text('Please enable internet to get the latest news', style: TextStyle(color: Colors.red, fontSize: 15, height: 1.4),));
          }),
    );
  }
}
