import 'package:flutter/material.dart';


/********************************/

const String kEmailHintText = 'Introduce Correo';
const String kPasswordHintText = 'Introduce Contraseña';



/*******************************/
const TextStyle kLogoTextStyle = TextStyle(
  fontSize: 50.0 ,
  fontWeight: FontWeight.w900,
  color: Colors.black54
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 25.0 ,
  letterSpacing: 1.5,
  fontWeight: FontWeight.w400,
  color: Colors.white
);

const TextStyle kMessageTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.white
);

const TextStyle kSenderTextStyle = TextStyle(
  fontSize: 10.0,
  color: Colors.blueGrey
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);


const InputDecoration kTextFieldDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  hintStyle: TextStyle(fontSize: 20.0),
  contentPadding:
  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kFieldEnabledColor , width: 1.5),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kFieldFocusColor),
      borderRadius: BorderRadius.all(
        Radius.circular(32.0),
      )),
);

// ***************** ANIMATION TAGS *****************

String kLogoAnimationTag = 'logo';

// ***************** colors *********************

const Color kRegisterButtonColor = Color(0xff0d47a1);
const Color kLoginButtonColor = Color(0xff1e88e5);
const Color kChatTextFieldColor = Color(0xffe0e0e0);
const Color kFieldFocusColor = Color(0xfffbc02d);
const Color kFieldEnabledColor = Color(0xff0288d1);