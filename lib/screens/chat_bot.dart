import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class ChatBot extends StatefulWidget {
  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  Gemini _gemini = Gemini.instance;

  TextEditingController _textEditingController = TextEditingController();

  String _response = '';

  void sendMessage(String message) {
    _gemini.text(message).then((response) {
      setState(() {
        _response = response?.output ?? "No response from the bot.";
      });
    }).catchError((error) {
      setState(() {
        _response = "Error: $error";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Query!!!',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
              Expanded(child: GeminiResponseTypeView(
                builder: (context, child, _response, isUser) {
                  if (!isUser) {
                    /// show loading animation or use CircularProgressIndicator();
                    return Center(child: Lottie.asset('assets/bot.json'));
                  }

                  /// The runtimeType of response is String?
                  if (_response != null) {
                    return Markdown(
                      data: _response,
                      selectable: false,
                    );
                  } else {
                    /// idle state
                    return const Center(child: Text('Please Wait!!!!'));
                  }
                },
              ),),

            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: 'Ask Me...',
                      focusColor: Colors.white38,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    onSubmitted: (String message) {
                      sendMessage(message);
                      _textEditingController.clear();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.circleArrowRight,size: 35,),
                    onPressed: () {
                      String message = _textEditingController.text.trim();
                      if (message.isNotEmpty) {
                        sendMessage(message);
                        _textEditingController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
