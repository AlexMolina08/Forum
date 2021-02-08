/*
* Message bubble representa un widget de un mensaje enviado en forum
* */

import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';



class MessageBubble extends StatelessWidget {
  final String sender, text ;
  final time;
  final bool isMe;

  //TODO IMPLEMENTAR MOSTRAR TIME

  MessageBubble({@required this.sender, @required this.text , this.isMe , this.time});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: kSenderTextStyle,
          ),
          
          Neumorphic(
            style: NeumorphicStyle(
              color: (isMe) ? NeumorphicTheme.variantColor(context) : kOthersMessageColor,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    // dependiendo de quien envíe el mensaje , ajustamos el widget a la derecha o a la izquierda
                    topLeft: (isMe) ? Radius.circular(20.0) : Radius.circular(0.0),
                    topRight: (isMe) ? Radius.circular(0.0) : Radius.circular(20.0)
                ),
              )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Text(
                '$text',
                style: (isMe) ? kMessageTextStyle : kOthersTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
