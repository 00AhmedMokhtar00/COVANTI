import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:solution_challenge/res/assets.dart';

import '../models/news_item.dart';


class NewsItemDesign extends StatelessWidget {
  NewsItemDesign({@required this.newsItem});
  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
          color: Color(0xfffffdff),
        ),
        child: LayoutBuilder(
          builder: (_, constrain){
            final constWidth = constrain.maxWidth;
            return Container(
              margin: const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: constWidth * 0.94,
                    height: constWidth * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: newsItem.img != ' '? CachedNetworkImageProvider(newsItem.img): AssetImage('assets/images/news.png')
                      ),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Text(newsItem.title??' ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
                  const SizedBox(height: 6,),
                  Text(newsItem.description??' ', style: TextStyle(fontSize: 9.5),textAlign: TextAlign.right,textDirection: TextDirection.rtl,),
                  Center(child: FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),child: Text('Read more',style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),onPressed: () =>Links.launchURL(newsItem.url),))

                ],
              ),
            );
          },
        )
    );
  }
}
