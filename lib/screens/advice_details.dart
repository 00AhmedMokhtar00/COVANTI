import 'package:flutter/material.dart';
import '../models/advice.dart';

class AdviceDetails extends StatelessWidget {
  final Advice advice;

  AdviceDetails({this.advice});

  @override
  Widget build(BuildContext context) {
    //final MQ = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(color: Colors.blue, icon: Icon(Icons.arrow_back_ios),iconSize: 30,onPressed: (){Navigator.pop(context);},),
      ),
      ),
      body: LayoutBuilder(
        builder: (_, constrains){
          return Column(

            children: <Widget>[
              SizedBox(height: 10,),
              Center(child: Text(advice.title, style: Theme.of(context).textTheme.body1,)),
              SizedBox(height: 15,),
              Container(
                margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                width: constrains.maxWidth * 0.5,
                height: constrains.maxWidth * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(advice.img),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: constrains.maxHeight * 0.5,
                  width: constrains.maxWidth,
                  child: ListView.builder(
                    itemBuilder: (_, i){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(margin: const EdgeInsets.only(left: 5, right: 5, top: 8),child: Icon(Icons.brightness_1, color: Theme.of(context).primaryColor, size: 10,)),
                            Expanded(child: Text(advice.description[i])),
                          ],
                        ),
                      );
                    },
                    itemCount: advice.description.length,
                  ),
                ),
              ),
            ],
          );
        },

      ),
    );
  }
}
