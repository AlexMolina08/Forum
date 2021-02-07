/*
* Message bubble representa un widget de un mensaje enviado en forum
* */

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String sender ,
               text;

  MessageBubble({this.sender , this.text});

  @override
  Widget build(BuildContext context) {
    return Text('$text ($sender)');
  }
}
