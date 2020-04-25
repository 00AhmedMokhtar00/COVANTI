import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Chatbot extends StatefulWidget {
  Chatbot({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _HomePageDialogflowV2 createState() => _HomePageDialogflowV2();
}

class _HomePageDialogflowV2 extends State<Chatbot> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool isSent = false;

  FlutterTts flutterTts = FlutterTts();
  SpeechRecognition _speechRecognition = SpeechRecognition();
  bool _isAvailable = false;
  bool _isListening = false;

  Future _speak(String txt) async {
    await flutterTts.speak(txt);
  }

  Future<void> initSpeechRecognizer() {
    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (_) => setState(() {
        _isListening = false;
        _handleSubmitted(_textController.text);
      }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      (String speech) => setState(() {
        !isSent ? _textController.text = speech : isSent = false;
      }),
    );

    _speechRecognition.activate().then(
          (result) => setState(() {
            _isAvailable = result;
          }),
        );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: "Send a message"),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.mic),
                onPressed: _onStartRecording,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 3.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void response(query) async {
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: "assets/chatbot.json",
    ).build();

    Dialogflow dialogflow = Dialogflow(
      authGoogle: authGoogle,
      language: Language.english,
    );
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = ChatMessage(
      text: response.getMessage() ??
          CardDialogflow(
            response.getListMessage()[0],
          ).title,
      name: "COVANTI",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
      _speak(response.getMessage());
    });
  }

  void _handleSubmitted(String text) {
    if (_textController.text.isNotEmpty) {
      isSent = true;
      //_textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        name: "Me",
        type: true,
      );
      setState(() {
        _messages.insert(0, message);
      });
      response(text);
    }
  }

  void _onStartRecording() async {
    await initSpeechRecognizer();
    await flutterTts.stop();
    if (_isAvailable && !_isListening) {
      await _speechRecognition.listen(locale: "en_US");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
        SizedBox(height: 30.0,),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0, bottom: 10.0, top: 10.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(child: Text('CovAnti',textAlign: TextAlign.justify, style: TextStyle(color: Theme.of(context).primaryColor),))
          ],
        ),
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({
    this.text,
    this.name,
    this.type,
  });

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.2),
          backgroundImage: AssetImage("assets/images/cov.png"),
          maxRadius: 20,
        ),
      ),
      Flexible(
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 6, right: 30),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0), topRight: Radius.circular(12.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 2)
              ]),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Flexible(
        child: Container(
          margin: const EdgeInsets.only(top: 6, left: 30, right: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), bottomLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 2
                )
              ]),
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 2)
        ]),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset("assets/images/doc.png",
              color: Theme.of(context).primaryColor),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
