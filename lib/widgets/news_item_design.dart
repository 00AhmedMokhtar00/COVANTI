import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_item.dart';


class NewsItemDesign extends StatelessWidget {
  final NewsItem newsItem;
  NewsItemDesign({@required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
          color: Colors.white,
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
                        image: NetworkImage(newsItem.img),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Text(newsItem.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
                  const SizedBox(height: 6,),
                  Text(newsItem.description, style: TextStyle(fontSize: 9),textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
                  Center(child: FlatButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),child: Text('Read more',style: TextStyle(color: Colors.blue),),onPressed: () =>_launchURL(newsItem.url),))

                ],
              ),
            );
          },
        )
    );
  }
}
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}