import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.text, required this.sender, required bool isImage});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sender)
            .text
            .subtitle1(context)
            .make()
            .box
            // .color(sender=="user" ?Vx.red200 : Vx.green200)
            .color(sender == "user" ? Vx.blue400 : Color.fromARGB(255, 67, 166, 141))
            .alignCenter
            .p16
            .rounded
            .makeCentered(),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: text
                .trim()
                .text
                .bodyText1(context)
                .color(Colors.white)
                .make()
                .px12()
                .backgroundColor(Color(0xff444654))
                .cornerRadius(5)),
      ],
    ).py8();
  
  }
}
