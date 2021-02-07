/*
*
* Textfield del chat de Forum , con un boton de enviar
*
* */

import 'package:flutter/material.dart';
import 'package:forum/constants.dart';


class ChatTextField extends StatefulWidget {

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Container(
        color: Color(0xffe0e0e0),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: 'Escribe un mensaje',
                      hintStyle: TextStyle(
                        color: Color(0xff9e9e9e),
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () {},
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
