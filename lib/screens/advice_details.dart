import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';
import '../models/advice.dart';

class AdviceDetails extends StatefulWidget {
  static const String routeName = "AdviceDetails";
  @override
  _AdviceDetailsState createState() => _AdviceDetailsState();
}

class _AdviceDetailsState extends State<AdviceDetails> {
  FlutterTts flutterTts = FlutterTts();

  bool isSpeaking = false;

  Future _speak(String txt) async{
    if(!isSpeaking) {
      setState(() {
        isSpeaking = true;
      });
      await flutterTts.speak(txt);
    }else{
      setState(() {
        isSpeaking = false;
      });
      await flutterTts.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Advice;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(color: Theme.of(context).primaryColor, icon: Icon(Icons.arrow_back_ios),iconSize: 30,onPressed: (){Navigator.pop(context);},),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.volume_up, color: Colors.white.withOpacity(0.9),size: 30,),
        onPressed: ()=> _speak(args.description.toString()),
      ),
      body: LayoutBuilder(
        builder: (_, constrains){
          return Column(

            children: <Widget>[
              SizedBox(height: 10,),
              Center(child: Text(PrefManager.tr(context, args.title), style: Theme.of(context).textTheme.body1,)),
              SizedBox(height: 15,),
              Container(
                margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                width: constrains.maxWidth * 0.5,
                height: constrains.maxWidth * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(args.img),
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
                            Expanded(child: Text(PrefManager.tr(context, args.description[i]), style: TextStyle(fontSize: 14),)),
                          ],
                        ),
                      );
                    },
                    itemCount: args.description.length,
                  ),
                ),
              ),
            ],
          );
        },

      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
