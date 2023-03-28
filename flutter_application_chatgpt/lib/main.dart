import 'package:flutter/material.dart';
import 'package:flutter_application_chatgpt/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT Demo',
      theme: ThemeData(
 
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
home: ChatScreen(),
    );
  }
}
