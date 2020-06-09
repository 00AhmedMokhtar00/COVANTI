import 'package:flutter/material.dart';
import '../localization/keys.dart';

import '../prefs/pref_manager.dart';
import '../models/news_item.dart';
import '../widgets/news_item_design.dart';
import '../widgets/title.dart';

class News extends StatelessWidget {
  static const String routeName = "News";
  static bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle(PrefManager.tr(context, LocKeys.NEWS_TITLE)),
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
            if(isConnected){
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text(PrefManager.tr(context, LocKeys.ACTIVATE_INTERNET_MSG), textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 15, height: 1.4),));
          }),
    );
  }
}
