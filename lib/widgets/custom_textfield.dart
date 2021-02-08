import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class CustomTextField extends StatelessWidget {

  final Function onChanged;
  String hintText;
  bool obscureText ;
  final GlobalKey<FormState> form ;
  final Function(String) validator;

  CustomTextField({this.hintText, this.onChanged , this.obscureText ,
    this.form , this.validator});

  @override
  Widget build(BuildContext context) {

    if(obscureText == null) obscureText = false;

    return Neumorphic(
        style: NeumorphicStyle(
          depth: 7.0,
          shape: NeumorphicShape.flat,
          boxShape:
          NeumorphicBoxShape.roundRect(BorderRadius.circular(32.0)),
        ),
        drawSurfaceAboveChild: true,
        child: Form(
          key: form,
          child: TextFormField(
            obscureText: obscureText,
            textAlign: TextAlign.center,
            onChanged: onChanged,
            decoration: kTextFieldDecoration.copyWith(hintText: hintText),
            validator: validator
          ),
        )
    );
  }
}


