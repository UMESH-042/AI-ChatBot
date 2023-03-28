import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_chatgpt/chatmessages.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessages> _messages = [];
  OpenAI? chatGPT;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    chatGPT = OpenAI.instance;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  // ChatGPT? chatGPT;

  // void sendMessage() {
  //   ChatMessages message = ChatMessages(text: _controller.text, sender: "user", isImage: false,);

  //   // _messages.clear();
  //   setState(() {
  //     _messages.insert(0, message);
  //   });
  //   _controller.clear();

  //   final request = CompleteText(
  //       prompt: message.text, model: kTranslateModelV3, maxTokens: 200);
  //   _subscription = chatGPT!
  //       .build(token: "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")
  //       .onCompleteStream(request: request)
  //       .listen((response) {
  //     Vx.log(response!.choices[0].text);
  //     ChatMessages botMessage =
  //         ChatMessages(text: response!.choices[0].text, sender: "bot", isImage: false,);
  //     // _messages.clear();
  //     setState(() {
  //       // _messages.clear();
  //       // _messages.add(botMessage);
  //       _messages.insert(0, botMessage);
  //     });
  //   });
  // }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    ChatMessages message = ChatMessages(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      // _isTyping = true;
    });

    _controller.clear();

    // if (_isImageSearch) {
    //   final request = GenerateImage(message.text, 1, size: "256x256");

    //   final response = await chatGPT!.generateImage(request);
    //   Vx.log(response!.data!.last!.url!);
    //   insertNewData(response.data!.last!.url!, isImage: true);
    // } else {
    final request =
        CompleteText(prompt: message.text, model: kTranslateModelV3);

    final response = await chatGPT!
        .build(token: "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")
        .onCompleteText(request: request);
    Vx.log(response!.choices[0].text);
    insertNewData(response.choices[0].text, isImage: false);
    // }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessages botMessage = ChatMessages(
      text: response,
      sender: "bot",
      isImage: isImage,
    );

    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildtextcomposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: InputDecoration.collapsed(
              hintText: "Send a message",
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _sendMessage();
          },
          icon: Icon(Icons.send),
          color: Colors.white54,
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black87,
        backgroundColor: Color(0xff444654),
        title: Text(
          'ChatGPT Demo',
          style: TextStyle(color: Colors.white60),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: ((context, index) {
                  return _messages[index];
                }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff444654),
              ),
              child: _buildtextcomposer(),
            ),
          ],
        ),
      ).backgroundColor(Color(0xff343541)),
    );
  }
}
