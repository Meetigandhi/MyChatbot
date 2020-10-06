import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:toast/toast.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Dashboard extends StatefulWidget {
  static const routeName = "/Dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _islistening = false;
  stt.SpeechToText _speech;
  double _confidence = 1.0;
  String _text = "",_ptext="";
  int _count=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech=stt.SpeechToText();
  }
  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/my-chat-bot-288511-84bddd906b97.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    //print(aiResponse.getListMessage()[0]["text"]["text"][0]);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
  }

  final messgecontroller = TextEditingController();

  List<Map> messages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
      ),
      body: Container(
//          child: Center(
//            child: RaisedButton(onPressed: () {
//              response("who are you?");
//            },child: Text("response"),),
//          )
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                  itemCount: messages.length,
                  padding: EdgeInsets.all(10.0),
                  reverse: true,
                  itemBuilder: (context, index) => messages[index]["data"] == 0
                      ? Row(
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/chatbot.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Bubble(
                                  radius: Radius.circular(15),
                                  color: Colors.green,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Container(
                                              width:(MediaQuery.of(context).size.width-60)*0.6,

                                              constraints:
                                              BoxConstraints(maxHeight: 200),
                                          child: Text(
                                            messages[index]["message"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                        )),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),

                              child: Bubble(
                                  radius: Radius.circular(15),
                                  color: Colors.blue,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(

                                            child: Container(
                                               constraints:
                                              BoxConstraints(maxHeight: 200),
                                          child: Text(
                                            messages[index]["message"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),

                                          ),
                                        )),
                                      ],
                                    ),
                                  )),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/human1.png"),
                              ),
                            ),
                          ],
                        )),
            ),
            Divider(
              height: 3.0,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: messgecontroller,
                      decoration: InputDecoration.collapsed(
                          hintText: "Send Your Message"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (messgecontroller.text.isEmpty) {
                          print("Empty Message");
                          Toast.show("Plz Enter Message", context,
                              duration: Toast.LENGTH_LONG);
                        } else {
                          setState(() {
                            messages.insert(0,
                                {"data": 1, "message": messgecontroller.text});
                          });
                          response(messgecontroller.text);
                          messgecontroller.clear();
                          //print(messages.length);
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(_islistening ? Icons.mic : Icons.mic_none),

                      onPressed: () {
                        _listen();

                      },

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _listen() async {
      if (!_islistening) {
        _count=0;
        _ptext="";
        _text="";
        bool available = await _speech.initialize(
          onStatus: (status) {
             print('onStatus: $status');
//             Toast.show('onStatus: $status', context,
//                 duration: Toast.LENGTH_LONG);
          },
          onError: (errorNotification) {
            print('onError : $errorNotification');
//            Toast.show('onError : $errorNotification', context,
//                duration: Toast.LENGTH_LONG);
          },
        );
        if (available) {
          setState(() {
            _islistening = true;
          });
          _speech.listen(onResult: (result) {
            _text = result.recognizedWords;
            if (result.hasConfidenceRating && result.confidence > 0) {
              _confidence = result.confidence;
            }
            setState(() {
              if(_text.trim().length>0 && _ptext.compareTo(_text)!=0 && _count==0 ) {
                messages.insert(0,
                    {"data": 1, "message": _text});
                response(_text);
                _count++;
                _ptext=_text;
                _text = "";

                _islistening=false;
              }
            });

          },);
        }
      }
      else {
        setState(() {
          _islistening = false;
          _count=0;
          _text="";
          _ptext="";
          _speech.stop();
        });
      }
    }


}
