import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class COVIDInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //const String COVID = '(COVID-19) is an infectious diseas caused by the servere acute respiratory syndrome coronavirus 2 (SARS-CoV-2).The diseas has spread globally since ...';
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey)],
            color: Colors.white,
          ),
          child: LayoutBuilder(
            builder: (_, constrain){
              final constWidth = constrain.maxWidth;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 5.0),
                    width: constWidth * 0.27,
                    height: constWidth * 0.27,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/covid.png"),
                      ),
                    ),
                  ),
                  Text('What is Coronavirus?', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Icon(Icons.navigate_next,color: Theme.of(context).primaryColor,size: 40,),
                ],
              );
            },
          )
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.cdc.gov/coronavirus/2019-ncov/faq.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
