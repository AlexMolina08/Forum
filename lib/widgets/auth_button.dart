/*
*
* AuthBotton representa un boton de las páginas de registro / auntetificación
*
* */
import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AuthButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;

  AuthButton({@required this.onPressed, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: kButtonTextStyle,
      ),
      style: NeumorphicStyle(
        depth: 10.0,
        shape: NeumorphicShape.flat,
      ),
    );

    /*Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text , style: kButtonTextStyle,),
      ),
    );*/
  }
}
