/*
* Message bubble representa un widget de un mensaje enviado en forum
* */

import 'package:flutter/material.dart';
import 'package:forum/constants.dart';



class MessageBubble extends StatelessWidget {
  final String sender, text;

  final Color color;

  MessageBubble({@required this.sender, @required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: kSenderTextStyle,
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0)
            ),
            elevation: 5.0,
            color: color,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Text(
                '$text',
                style: kMessageTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
